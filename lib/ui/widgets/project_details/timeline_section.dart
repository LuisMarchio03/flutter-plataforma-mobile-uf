import 'package:flutter/material.dart';

class TimelineSection extends StatelessWidget {
  const TimelineSection({super.key});

  @override
  Widget build(BuildContext context) {
    final timeline = [
      {
        'title': 'Análise de Requisitos',
        'date': '15/03/2023 - 15/04/2023',
        'responsavel': 'Ana Carolina Silva',
        'status': 'Concluído',
        'color': Colors.pinkAccent
      },
      {
        'title': 'Desenvolvimento Módulo Vendas',
        'date': '16/04/2023 - 30/06/2023',
        'responsavel': 'Marcos Oliveira',
        'status': 'Em progresso',
        'color': Colors.blueAccent
      },
      {
        'title': 'Desenvolvimento Módulo Estoque',
        'date': '01/07/2023 - 15/08/2023',
        'responsavel': 'Juliana Santos',
        'status': 'Pendente',
        'color': Colors.grey
      },
      {
        'title': 'Integração e Testes',
        'date': '16/08/2023 - 30/11/2023',
        'responsavel': 'Equipe completa',
        'status': 'Pendente',
        'color': Colors.grey
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF181A29),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Linha do Tempo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          ...timeline.map((item) => Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.check_circle, color: item['color'] as Color),
                title: Text(item['title'] as String, style: const TextStyle(color: Colors.white)),
                subtitle: Text(
                  '${item['date']}\nResponsável: ${item['responsavel']}',
                  style: const TextStyle(color: Colors.grey),
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: (item['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(item['status'] as String, style: TextStyle(color: item['color'] as Color)),
                ),
              ),
              if (item != timeline.last) const Divider(color: Colors.pinkAccent, height: 24)
            ],
          ))
        ],
      ),
    );
  }
}
