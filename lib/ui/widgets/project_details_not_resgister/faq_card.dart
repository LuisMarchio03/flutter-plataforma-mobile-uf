import 'package:flutter/material.dart';

class FaqCard extends StatelessWidget {
  const FaqCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF181C2F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Perguntas Frequentes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildFaqItem(
            'Como funciona o processo de seleção?',
            'O processo de seleção é feito através da análise do perfil do aluno e sua compatibilidade com o projeto.'
          ),
          _buildFaqItem(
            'Posso me inscrever em mais de um projeto?',
            'Sim, você pode se inscrever em quantos projetos desejar, mas só poderá participar de um por vez.'
          ),
          _buildFaqItem(
            'Como saberei se fui selecionado?',
            'Você receberá uma notificação no aplicativo e um e-mail informando sobre sua seleção.'
          ),
        ],
      ),
    );
  }
  
  Widget _buildFaqItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      collapsedIconColor: Colors.white,
      iconColor: Colors.pinkAccent,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            answer,
            style: const TextStyle(color: Colors.white70),
          ),
        ),
      ],
    );
  }
}
