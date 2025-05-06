import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bem-vindo de volta!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text('Você tem N Projetos em andamento', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
