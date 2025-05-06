import 'package:flutter/material.dart';
import '../widgets/header_widget.dart';
import '../widgets/welcome_card.dart';
import '../widgets/project_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderWidget(),
                const SizedBox(height: 20),
                const WelcomeCard(),
                const SizedBox(height: 24),
                const Text(
                  'Projetos em Andamento',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...List.generate(3, (_) => const ProjectCard(ongoing: true)),
                const SizedBox(height: 24),
                const Text(
                  'Projetos Disponíveis',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...List.generate(2, (_) => const ProjectCard(ongoing: false)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
