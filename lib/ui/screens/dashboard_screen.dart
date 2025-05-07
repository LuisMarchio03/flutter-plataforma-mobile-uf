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
  late Future<List<Project>> _enrolledProjectsFuture;
  
  @override
  void initState() {
    super.initState();
    // Initialize the futures here
    _projectsFuture = _loadProjects();
    _enrolledProjectsFuture = _loadEnrolledProjects();
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
  
  Future<List<Project>> _loadEnrolledProjects() async {
    try {
      // Usar o ProjectService para buscar os projetos inscritos
      return await ProjectService().getEnrolledProjects();
    } catch (e) {
      // Capturar e tratar erros
      print('Erro ao carregar projetos inscritos: $e');
      // Retornar uma lista vazia em caso de erro
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
  }

  void _reloadProjects() {
    setState(() {
      _projectsFuture = _loadProjects();
      _enrolledProjectsFuture = _loadEnrolledProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<List<List<Project>>>(
            future: Future.wait([_projectsFuture, _enrolledProjectsFuture]),
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

              final allProjects = snapshot.data?[0] ?? [];
              final enrolledProjects = snapshot.data?[1] ?? [];
              
              // Dividir projetos inscritos entre pendentes e em andamento
              final pendingProjects = enrolledProjects.where((p) => p.status == 'pending').toList();
              final ongoingEnrolledProjects = enrolledProjects.where((p) => p.status == 'approved').toList();
              
              // Filtrar projetos disponíveis (excluindo os inscritos)
              final enrolledIds = enrolledProjects.map((p) => p.id).toSet();
              final availableProjects = allProjects
                  .where((p) => !p.isOngoing && !enrolledIds.contains(p.id))
                  .toList();

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
                        child: WelcomeCard(projectCount: enrolledProjects.length),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Projetos Inscritos',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${pendingProjects.length} projeto(s)',
                          style: const TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Mensagem quando não há projetos inscritos
                    if (pendingProjects.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF181C2F),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.assignment_outlined,
                                color: Colors.white70,
                                size: 48,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Você não está inscrito em nenhum projeto no momento.',
                                style: TextStyle(color: Colors.white70),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Inscreva-se em um projeto disponível para começar.',
                                style: TextStyle(color: Colors.white70, fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      Column(
                        children: [
                          ...pendingProjects.map((project) => ProjectCard(
                            project: project,
                            ongoing: false,
                            status: 'pending',
                          )),
                          const SizedBox(height: 8),
                          if (pendingProjects.length > 3)
                            TextButton(
                              onPressed: () {
                                // Navegação para uma tela com todos os projetos inscritos
                                // Navigator.pushNamed(context, '/projects/enrolled');
                              },
                              child: const Text(
                                'Ver todos os projetos inscritos',
                                style: TextStyle(color: Colors.pinkAccent),
                              ),
                            ),
                        ],
                      ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Projetos em Andamento',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${ongoingEnrolledProjects.length} projeto(s)',
                          style: const TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Mensagem quando não há projetos em andamento
                    if (ongoingEnrolledProjects.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF181C2F),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.assignment_outlined,
                                color: Colors.white70,
                                size: 48,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Você não possui projetos em andamento no momento.',
                                style: TextStyle(color: Colors.white70),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Aguarde a aprovação de suas inscrições ou inscreva-se em novos projetos.',
                                style: TextStyle(color: Colors.white70, fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      Column(
                        children: [
                          ...ongoingEnrolledProjects.map((project) => ProjectCard(
                            project: project,
                            ongoing: true,
                            status: 'approved',
                          )),
                          const SizedBox(height: 8),
                          if (ongoingEnrolledProjects.length > 3)
                            TextButton(
                              onPressed: () {
                                // Navegação para uma tela com todos os projetos em andamento
                                // Navigator.pushNamed(context, '/projects/ongoing');
                              },
                              child: const Text(
                                'Ver todos os projetos em andamento',
                                style: TextStyle(color: Colors.pinkAccent),
                              ),
                            ),
                        ],
                      ),
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
