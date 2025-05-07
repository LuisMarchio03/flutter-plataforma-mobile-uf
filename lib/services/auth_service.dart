import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'http://localhost:8080/api';
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  
  // Método para salvar o token
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }
  
  // Método para obter o token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }
  
  // Método para verificar se o token existe
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
  
  // Método para limpar o token (logout)
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }

  // Método para salvar o ID do usuário
  Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdKey, userId);
    print('ID do usuário salvo: $userId');
  }
  
  // Método para obter o ID do usuário
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(userIdKey);
    print('ID do usuário recuperado: $userId');
    return userId;
  }

  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        print('Resposta do login: ${response.body}');
        final authResponse = AuthResponse.fromJson(jsonDecode(response.body));
        // Salvar o token após login bem-sucedido
        await saveToken(authResponse.token!);
        // Salvar o ID do usuário se disponível na resposta
        if (authResponse.user?.id != null) {
          print('ID do usuário encontrado na resposta: ${authResponse.user!.id}');
          await saveUserId(authResponse.user!.id!);
        } else {
          print('ID do usuário não encontrado na resposta');
          // Tentar extrair o ID do usuário diretamente do payload do token (JWT)
          if (authResponse.token != null && authResponse.token!.isNotEmpty) {
            try {
              final parts = authResponse.token!.split('.');
              if (parts.length == 3) {
                final payload = parts[1];
                final normalized = base64Url.normalize(payload);
                final decodedPayload = utf8.decode(base64Url.decode(normalized));
                final payloadMap = jsonDecode(decodedPayload) as Map<String, dynamic>;
                
                // Verificar se o token contém o ID do usuário (sub ou user_id são comuns)
                final userId = payloadMap['sub'] ?? payloadMap['user_id'];
                if (userId != null) {
                  print('ID do usuário extraído do token: $userId');
                  await saveUserId(userId.toString());
                }
              }
            } catch (e) {
              print('Erro ao tentar extrair ID do usuário do token: $e');
            }
          }
        }
        return authResponse;
      } else {
        print('Falha na autenticação: ${response.statusCode} - ${response.body}');
        throw Exception('Falha na autenticação');
      }
    } catch (e) {
      print('Erro ao conectar com o servidor: $e');
      throw Exception('Erro ao conectar com o servidor');
    }
  }
  
  // Método para verificar se o token ainda é válido (versão temporária)
  Future<bool> validateToken() async {
    try {
      final token = await getToken();
      // Temporarily just check if token exists
      return token != null && token.isNotEmpty;
      
      // TODO: Implement proper token validation when backend endpoint is available
    } catch (e) {
      print('Token validation error: $e');
      return false;
    }
  }
  
  // Método para limpar todos os dados de autenticação (logout completo)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    await prefs.remove(userIdKey);
  }
}