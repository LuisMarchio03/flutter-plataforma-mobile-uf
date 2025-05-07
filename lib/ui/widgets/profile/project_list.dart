import 'package:flutter/material.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Meus Projetos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ProjectItem(
          title: 'Sistema de Monitoramento IoT',
          role: 'Líder de Equipe',
          deadline: '15/12/2023',
          progress: 0.75,
        ),
        const SizedBox(height: 12),
        ProjectItem(
          title: 'Aplicativo de Gestão Acadêmica',
          role: 'Desenvolvedor',
          deadline: '28/02/2024',
          progress: 0.30,
        ),
      ],
    );
  }
}

class ProjectItem extends StatelessWidget {
  final String title;
  final String role;
  final String deadline;
  final double progress;

  const ProjectItem({
    super.key,
    required this.title,
    required this.role,
    required this.deadline,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Papel: $role',
                style: const TextStyle(color: Colors.white70),
              ),
              const Spacer(),
              Text(
                'Prazo: $deadline',
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFD3664)),
          ),
          const SizedBox(height: 4),
          Text(
            '${(progress * 100).toInt()}% concluído',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}