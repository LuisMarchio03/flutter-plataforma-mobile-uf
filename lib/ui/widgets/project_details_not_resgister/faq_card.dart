import 'package:flutter/material.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/first_card.dart';

class FaqCard extends StatelessWidget {
  const FaqCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      title: "Dúvidas Frequentes",
      children: const [
        _FaqItem(
          question: "Quem pode participar?",
          answer: "Qualquer aluno da instituição com interesse em desenvolvimento mobile.",
        ),
        _FaqItem(
          question: "Receberei certificado?",
          answer: "Sim, após a conclusão do projeto e entrega final.",
        ),
        _FaqItem(
          question: "Posso usar isso como horas complementares?",
          answer: "Sim, o projeto conta como atividade de extensão acadêmica.",
        ),
      ],
    );
  }
}

class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(answer, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
