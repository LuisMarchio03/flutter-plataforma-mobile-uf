import 'package:flutter/material.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/header_widget.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/first_card.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/section_card.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/requirements_card.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/dates_card.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/responsible_card.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/faq_card.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/apply_button.dart';
import '../../models/project.dart';

class ProjectDetailsNotRegister extends StatelessWidget {
  final Project project;
  
  const ProjectDetailsNotRegister({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Detalhes do Projeto: ${project.title}"),
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            HeaderWidget(project: project),
            const SizedBox(height: 16),
            // FirstCard(project: project),
            SectionCard(project: project),
            RequirementsCard(project: project),
            DatesCard(project: project),
            ResponsibleCard(project: project),
            FaqCard(),
            const SizedBox(height: 24),
            ApplyButton(project: project),
          ],
        ),
      ),
    );
  }
}
