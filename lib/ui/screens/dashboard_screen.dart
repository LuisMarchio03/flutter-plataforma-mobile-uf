import 'package:flutter/material.dart';
import '../widgets/header_widget.dart';
import '../widgets/welcome_card.dart';
import '../widgets/project_card.dart';
import '../../models/project.dart';
import '../../services/project_service.dart';
import '../../controllers/login_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<List<Project>> _projectsFuture;
  
  @override
  void initState() {
    super.initState();
    // Initialize the _projectsFuture here
    _projectsFuture = _loadProjects();
  }
  
  Future<List<Project>> _loadProjects() async {
    try {
      // Usar o ProjectService para buscar os projetos
      return await ProjectService().getProjects();
    } catch (e) {
      // Capturar e tratar erros
      print('Erro ao carregar projetos: $e');
      // Retornar uma lista vazia em caso de erro para evitar null
      return [];
    }
  }
  
  void _handleError(String error) {
    // Não redireciona para login na primeira carga
    if (error.contains('Session expired') || error.contains('No authentication token')) {
      Future.microtask(() {
        LoginController().logout(); // Limpar o token ao detectar sessão expirada
        Navigator.of(context).pushReplacementNamed('/');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sua sessão expirou. Por favor, faça login novamente.')),
        );
      });
    }
// Remove _isFirstLoad line since it's not defined or needed in this context
  }

  void _reloadProjects() {
    setState(() {
      _projectsFuture = _loadProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<List<Project>>(
            future: _projectsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                _handleError(snapshot.error.toString());
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Erro ao carregar projetos',
                        style: TextStyle(color: Colors.white),
                      ),
                      ElevatedButton(
                        onPressed: _reloadProjects,
                        child: const Text('Tentar Novamente'),
                      ),
                    ],
                  ),
                );
              }

              final projects = snapshot.data ?? [];
              final ongoingProjects = projects.where((p) => p.isOngoing).toList();
              final availableProjects = projects.where((p) => !p.isOngoing).toList();

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderWidget(),
                    const SizedBox(height: 20),
                    // Card de boas-vindas com largura e altura ajustadas
                    Center(
                      child: Container(
                        width: double.infinity, // Ocupa toda a largura disponível
                        constraints: const BoxConstraints(minHeight: 120), // Altura mínima
                        child: WelcomeCard(projectCount: ongoingProjects.length),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Projetos em Andamento',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    // Mensagem quando não há projetos em andamento
                    if (ongoingProjects.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF181C2F),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text(
                            'Você não possui projetos em andamento no momento.',
                            style: TextStyle(color: Colors.white70),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    else
                      ...ongoingProjects.map((project) => ProjectCard(
                        project: project,
                        ongoing: true,
                      )),
                    const SizedBox(height: 24),
                    const Text(
                      'Projetos Disponíveis',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    // Mensagem quando não há projetos disponíveis
                    if (availableProjects.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF181C2F),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Text(
                            'Não há projetos disponíveis no momento.',
                            style: TextStyle(color: Colors.white70),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    else
                      ...availableProjects.map((project) => ProjectCard(
                        project: project,
                        ongoing: false,
                      )),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
