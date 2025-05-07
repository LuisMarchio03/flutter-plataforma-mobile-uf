import 'package:flutter/material.dart';
import '../../models/project.dart';
import 'info_tag.dart';
import '../screens/project_details_not_register.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final bool ongoing;
  final String? status;

  const ProjectCard({
    super.key, 
    required this.project,
    required this.ongoing,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF181C2F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ongoing ? _buildOngoingContent() : _buildAvailableContent(context),
    );
  }

  Widget _buildOngoingContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(project.title, 
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
        const SizedBox(height: 4),
        Text('Criado por: ${project.createdBy}', 
          style: const TextStyle(color: Colors.white70)
        ),
        const SizedBox(height: 12),
        LinearProgressIndicator(
          value: 0.5, // Valor fixo ou calculado de outra forma
          backgroundColor: Colors.white12,
          color: Colors.deepPurpleAccent,
          minHeight: 6,
          borderRadius: BorderRadius.circular(10),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('50% concluído', 
              style: TextStyle(color: Colors.white70)
            ),
            Text('Atualizado: ${_formatDate(project.updatedAt)}', 
              style: const TextStyle(color: Colors.white70)
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAvailableContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(project.title, 
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
        const SizedBox(height: 4),
        Text('Status: ${project.status}', 
          style: const TextStyle(color: Colors.white70)
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InfoTag(label: 'Criado: ${_formatDate(project.createdAt)}', color: Colors.pinkAccent),
            InfoTag(label: 'ID: ${project.id.substring(0, 8)}...', color: Colors.pinkAccent),
          ],
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              // Navegar para a tela de detalhes do projeto
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProjectDetailsNotRegister(project: project),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text('Ver detalhes'),
          ),
        ),
      ],
    );
  }
  
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
