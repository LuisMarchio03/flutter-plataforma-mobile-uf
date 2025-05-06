import 'package:flutter/material.dart';

class AddTaskModal extends StatefulWidget {
  final void Function(Map<String, dynamic> task) onSave;

  const AddTaskModal({super.key, required this.onSave});

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController responsibleController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nova Tarefa', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 16),
            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Nome da Tarefa',
                labelStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Color(0xFF202437),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: responsibleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Responsável',
                labelStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Color(0xFF202437),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) setState(() => startDate = picked);
                    },
                    child: Text(startDate != null ? 'Início: ${_formatDate(startDate!)}' : 'Selecionar Início'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) setState(() => endDate = picked);
                    },
                    child: Text(endDate != null ? 'Fim: ${_formatDate(endDate!)}' : 'Selecionar Fim'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              dropdownColor: const Color(0xFF202437),
              value: selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Status',
                labelStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Color(0xFF202437),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
              items: ['Pendente', 'Em andamento', 'Finalizado']
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status, style: const TextStyle(color: Colors.white)),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => selectedStatus = value),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      startDate != null &&
                      endDate != null &&
                      selectedStatus != null) {
                    widget.onSave({
                      'title': titleController.text,
                      'responsible': responsibleController.text,
                      'start': startDate,
                      'end': endDate,
                      'status': selectedStatus,
                    });
                    Navigator.of(context).pop();
                  }
                },
                label: const Text('Salvar Tarefa'),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
