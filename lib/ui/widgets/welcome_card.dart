import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  final int projectCount;

  const WelcomeCard({super.key, required this.projectCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Bem-vindo de volta!', 
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
          ),
          Text(
            'Você tem $projectCount projetos em andamento',
            style: const TextStyle(color: Colors.white)
          ),
        ],
      ),
    );
  }
}
