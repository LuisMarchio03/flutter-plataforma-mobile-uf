import 'package:flutter/material.dart';

class FirstCard extends StatelessWidget {
  const FirstCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      title: "Descrição Resumida",
      children: const [
        Text(
          "Este projeto visa desenvolver um aplicativo educacional para auxiliar estudantes do ensino fundamental no aprendizado de matemática básica através de jogos interativos e desafios personalizados.",
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}

class SectionContainer extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SectionContainer({
    required this.title,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }
}
