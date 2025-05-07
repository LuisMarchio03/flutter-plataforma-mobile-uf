import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/project.dart';
import '../services/auth_service.dart';
// TODO: Create ApiConfig class with baseUrl constant
const String apiBaseUrl = 'http://localhost:8080/api';

class ProjectService {
  static const String baseUrl = 'http://localhost:8080/api';
  final AuthService _authService = AuthService();

  Future<List<Project>> getProjects() async {
    try {
      final token = await _authService.getToken();
      if (token == null) {
        throw Exception('No authentication token');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/projects'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> projectsJson = jsonDecode(response.body);
        return projectsJson.map((json) => Project.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        throw Exception('Session expired');
      } else {
        throw Exception('Failed to load projects');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  Future<List<Project>> getEnrolledProjects() async {
    try {
      final token = await _authService.getToken();
      if (token == null) {
        throw Exception('No authentication token');
      }

      final response = await http.get(
        Uri.parse('$apiBaseUrl/applications/user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> projectsJson = responseData['projects'] ?? [];
        
        // Aqui está o problema - precisamos garantir que o status da aplicação 
        // seja corretamente atribuído ao objeto Project
        List<Project> projects = [];
        for (var json in projectsJson) {
          Project project = Project.fromJson(json['project'] ?? json);
          // Atribuir o status da aplicação ao projeto
          project = Project(
            id: project.id,
            title: project.title,
            description: project.description,
            status: json['status'] ?? 'unknown', // Usar o status da aplicação
            createdBy: project.createdBy,
            createdAt: project.createdAt,
            updatedAt: project.updatedAt,
            isOngoing: json['status'] == 'approved', // Projeto em andamento se aprovado
          );
          projects.add(project);
        }
        return projects;
      } else if (response.statusCode == 401) {
        throw Exception('Session expired');
      } else {
        throw Exception('Failed to load enrolled projects');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}