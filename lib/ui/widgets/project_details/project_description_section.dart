import 'package:flutter/material.dart';

class ProjectDescriptionSection extends StatelessWidget {
  const ProjectDescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF181A29),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Descrição do Projeto', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text('Objetivo Principal', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(
            'Desenvolver e implementar um sistema integrado de gestão empresarial que unifique os processos de vendas, estoque, financeiro e recursos humanos, aumentando a eficiência operacional em 40%.',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 16),
          Text('Etapas e Entregáveis', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text('- Módulo de Vendas e CRM (30/06/2023)', style: TextStyle(color: Colors.grey)),
          Text('- Módulo de Estoque e Logística (15/08/2023)', style: TextStyle(color: Colors.grey)),
          Text('- Módulo Financeiro (30/09/2023)', style: TextStyle(color: Colors.grey)),
          Text('- Módulo de RH e Integração Final (15/11/2023)', style: TextStyle(color: Colors.grey)),
          Text('- Treinamento e Documentação (30/11/2023)', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 16),
          Text('Relevância e Impacto', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(
            'O projeto visa reduzir em 35% o tempo gasto em processos administrativos, eliminar redundâncias e proporcionar insights estratégicos através de dashboards integrados, com economia anual estimada de R\$ 450.000.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
