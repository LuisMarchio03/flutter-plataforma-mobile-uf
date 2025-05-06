import 'package:flutter/material.dart';
import 'package:myapp/ui/widgets/project_details/add_task_modal.dart';

class TasksSection extends StatelessWidget {
  const TasksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = [
      {'status': 'Pendente', 'color': Colors.grey},
      {'status': 'Em andamento', 'color': Colors.blueAccent},
      {'status': 'Finalizado', 'color': Colors.green},
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
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
            children: [
              const Text(
                'Tarefas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: const Color(0xFF181A29),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    builder:
                        (context) => AddTaskModal(
                          onSave: (task) {
                            // Aqui você pode tratar os dados da nova tarefa
                            // Ex: atualizar o estado ou chamar uma API
                            print('Nova tarefa: $task');
                          },
                        ),
                  );
                },

                icon: const Icon(Icons.add, color: Colors.pinkAccent),
                label: const Text(
                  'Nova Tarefa',
                  style: TextStyle(color: Colors.pinkAccent),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Suas Tarefas Pendentes',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          ...List.generate(tasks.length, (index) {
            final task = tasks[index];
            return Card(
              color: const Color(0xFF202437),
              margin: const EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                leading: const Icon(
                  Icons.check_circle,
                  color: Colors.pinkAccent,
                ),
                title: const Text(
                  'Integração e Testes',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text(
                  '16/08/2023 - 30/11/2023\nResponsável: Teste',
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: (task['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    task['status'] as String,
                    style: TextStyle(color: task['color'] as Color),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
