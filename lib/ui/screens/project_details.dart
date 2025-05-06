import 'package:flutter/material.dart';
import 'package:myapp/ui/widgets/project_details/header_section.dart';
import 'package:myapp/ui/widgets/project_details/project_description_section.dart';
import 'package:myapp/ui/widgets/project_details/timeline_section.dart';
import 'package:myapp/ui/widgets/project_details/task_section.dart';

class ProjectDetails extends StatelessWidget {
  const ProjectDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F111C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Detalhes do Projeto"),
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HeaderSection(),
            SizedBox(height: 24),
            ProjectDescriptionSection(),
            SizedBox(height: 24),
            TimelineSection(),
            SizedBox(height: 24),
            TasksSection(),
          ],
        ),
      ),
    );
  }
}
