import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../models/project.dart';
import '../../../services/auth_service.dart';
// TODO: Create ApiConfig class with baseUrl constant
const String apiBaseUrl = 'http://localhost:8080/api';

class ApplyButton extends StatelessWidget {
  final Project project;
    
  const ApplyButton({
    super.key,
    required this.project,
  });

  Future<void> _applyForProject(BuildContext context) async {
    try {
      // Obter o token de autenticação
      final token = await AuthService().getToken();
      
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Você precisa estar logado para se inscrever em um projeto'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      
      // Obter o ID do usuário atual
      final userId = await AuthService().getUserId();
      
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Não foi possível obter o ID do usuário'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      
      // Imprimir informações para depuração
      print('Enviando inscrição para o projeto: ${project.id}');
      print('ID do usuário: $userId');
      
      // Preparar o payload da requisição
      final payload = {
        'project_id': project.id,
        // 'user_id': userId,
        'message': 'Tenho interesse em participar deste projeto'
      };
      
      print('Payload: ${jsonEncode(payload)}');
      
      // Fazer a requisição para a API
      final response = await http.post(
        Uri.parse('$apiBaseUrl/applications'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(payload),
      );
      
      print('Status code: ${response.statusCode}');
      print('Resposta: ${response.body}');
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        // Inscrição realizada com sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Inscrição enviada para o projeto: ${project.title}'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Voltar para a tela anterior após inscrição
        Navigator.pop(context);
      } else {
        // Erro ao realizar inscrição
        String errorMessage = 'Erro desconhecido';
        try {
          final errorData = jsonDecode(response.body);
          errorMessage = errorData['message'] ?? errorData['error'] ?? 'Erro desconhecido';
        } catch (e) {
          errorMessage = 'Erro ao processar resposta do servidor: ${response.body}';
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao se inscrever: $errorMessage'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Erro de conexão ou outro erro
      print('Erro ao se inscrever: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao se inscrever: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () => _applyForProject(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pinkAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          'Inscrever-se neste Projeto',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
