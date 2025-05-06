import 'package:flutter/material.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/first_card.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      title: "Objetivos e Benefícios",
      children: const [
        _ListItem(icon: Icons.school, text: "Estimular o aprendizado lúdico de matemática."),
        _ListItem(icon: Icons.group, text: "Incentivar a colaboração entre estudantes."),
        _ListItem(icon: Icons.star, text: "Oferecer uma experiência personalizada."),
      ],
    );
  }
}

class _ListItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ListItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.pinkAccent, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
