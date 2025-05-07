import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'http://localhost:8080/api';
  static const String tokenKey = 'auth_token';
  
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
        final authResponse = AuthResponse.fromJson(jsonDecode(response.body));
        // Salvar o token após login bem-sucedido
        await saveToken(authResponse.token!);
        return authResponse;
      } else {
        throw Exception('Falha na autenticação');
      }
    } catch (e) {
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
}