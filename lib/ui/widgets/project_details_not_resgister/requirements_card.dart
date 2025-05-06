import 'package:flutter/material.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/first_card.dart';

class RequirementsCard extends StatelessWidget {
  const RequirementsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      title: "Requisitos para Participação",
      children: const [
        _BulletPoint(text: "Conhecimento básico em Flutter."),
        _BulletPoint(text: "Disponibilidade de 10h semanais."),
        _BulletPoint(text: "Interesse por tecnologia educacional."),
      ],
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;

  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.circle, size: 8, color: Colors.pinkAccent),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(color: Colors.white))),
      ],
    );
  }
}
