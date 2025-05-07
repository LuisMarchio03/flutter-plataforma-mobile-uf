import 'package:flutter/material.dart';
import '../../../models/project.dart';

class ApplyButton extends StatelessWidget {
  final Project project;
  
  const ApplyButton({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // Lógica para se inscrever no projeto
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Inscrição enviada para o projeto: ${project.title}'),
              backgroundColor: Colors.green,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pinkAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          'Inscrever-se neste Projeto',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
