import 'package:flutter/material.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/first_card.dart';

class DatesCard extends StatelessWidget {
  const DatesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      title: "Cronograma",
      children: const [
        _DateRow(label: "Início das Inscrições:", date: "01/06/2025"),
        _DateRow(label: "Encerramento das Inscrições:", date: "15/06/2025"),
        _DateRow(label: "Início do Projeto:", date: "20/06/2025"),
      ],
    );
  }
}

class _DateRow extends StatelessWidget {
  final String label;
  final String date;

  const _DateRow({required this.label, required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(color: Colors.white))),
          Text(date, style: const TextStyle(color: Colors.pinkAccent)),
        ],
      ),
    );
  }
}
