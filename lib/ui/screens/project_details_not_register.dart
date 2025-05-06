import 'package:flutter/material.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/header_widget.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/first_card.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/section_card.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/requirements_card.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/dates_card.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/responsible_card.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/faq_card.dart';
import 'package:myapp/ui/widgets/project_details_not_resgister/apply_button.dart';

class ProjectDetailsNotRegister extends StatelessWidget {
  const ProjectDetailsNotRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Detalhes do Projeto (Não cadastrado)"),
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            HeaderWidget(),
            SizedBox(height: 16),
            FirstCard(),
            SectionCard(),
            RequirementsCard(),
            DatesCard(),
            ResponsibleCard(),
            FaqCard(),
            SizedBox(height: 24),
            ApplyButton(),
          ],
        ),
      ),
    );
  }
}
