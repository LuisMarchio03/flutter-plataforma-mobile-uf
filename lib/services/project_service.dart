import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/project.dart';
import '../services/auth_service.dart';

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
        Uri.parse('$baseUrl/projects/enrolled'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> projectsJson = responseData['projects'] ?? [];
        return projectsJson.map((json) => Project.fromJson(json)).toList();
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