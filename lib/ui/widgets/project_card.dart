import 'package:flutter/material.dart';
import 'info_tag.dart';

class ProjectCard extends StatelessWidget {
  final bool ongoing;

  const ProjectCard({super.key, required this.ongoing});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF181C2F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ongoing ? _buildOngoingContent() : _buildAvailableContent(),
    );
  }

  Widget _buildOngoingContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Desenvolvimento Sustentável', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        const Text('Prof. Teste 01 · Sistemas', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 12),
        LinearProgressIndicator(
          value: 0.65,
          backgroundColor: Colors.white12,
          color: Colors.deepPurpleAccent,
          minHeight: 6,
          borderRadius: BorderRadius.circular(10),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('65% concluído', style: TextStyle(color: Colors.white70)),
            Text('Prazo: 20/01/2024', style: TextStyle(color: Colors.white70)),
          ],
        ),
      ],
    );
  }

  Widget _buildAvailableContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Desenvolvimento Sistema 01', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        const Text('Prof. Teste 01 · Sistemas', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            InfoTag(label: '40 Horas Comp.', color: Colors.pinkAccent),
            InfoTag(label: 'Semestre 2024/1', color: Colors.pinkAccent),
          ],
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {},
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
}
