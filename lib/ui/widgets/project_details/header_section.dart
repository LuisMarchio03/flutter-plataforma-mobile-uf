import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF181A29),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(
                child: Text(
                  'Sistema de Gestão Integrada',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(Icons.edit, color: Colors.pinkAccent)
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('Em andamento', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Data de início', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 4),
                  Text('15/03/2023', style: TextStyle(color: Colors.white)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Prazo final', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 4),
                  Text('30/11/2023', style: TextStyle(color: Colors.white)),
                ],
              )
            ],
          ),
          const Divider(height: 32, color: Colors.pinkAccent),
          const Text(
            'Líder do Projeto',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                child: Icon(Icons.person, color: Colors.pinkAccent),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Ana Carolina Silva', style: TextStyle(color: Colors.white)),
                  Text('ana.silva@empresa.com', style: TextStyle(color: Colors.grey)),
                  Text('(11) 98765-4321', style: TextStyle(color: Colors.grey)),
                ],
              )
            ],
          ),
          const Divider(height: 32, color: Colors.pinkAccent),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Participantes', style: TextStyle(color: Colors.white)),
              TextButton(
                onPressed: () {},
                child: const Text('Ver todos', style: TextStyle(color: Colors.pinkAccent)),
              ),
            ],
          ),
          Row(
            children: [
              ...List.generate(3, (index) => const Padding(
                padding: EdgeInsets.only(right: 4.0),
                child: CircleAvatar(radius: 12, backgroundColor: Colors.white24),
              )),
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: const Text('+5', style: TextStyle(fontSize: 12, color: Colors.white)),
              )
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.pinkAccent),
              ),
              child: const Text('Chat', style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}