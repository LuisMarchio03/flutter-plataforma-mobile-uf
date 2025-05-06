import 'package:flutter/material.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/first_card.dart';

class ResponsibleCard extends StatelessWidget {
  const ResponsibleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      title: "Responsável pelo Projeto",
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/avatar_placeholder.png'),
              radius: 24,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Prof. João da Silva", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text("joao.silva@universidade.edu", style: TextStyle(color: Colors.white70)),
              ],
            )
          ],
        ),
      ],
    );
  }
}
