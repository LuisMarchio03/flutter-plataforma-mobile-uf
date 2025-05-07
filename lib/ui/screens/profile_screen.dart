import 'package:flutter/material.dart';
import '../widgets/profile/profile_header.dart';
import '../widgets/profile/user_info_card.dart';
import '../widgets/profile/project_stats_card.dart';
import '../widgets/profile/project_list.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F1B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            ProfileHeader(),
            SizedBox(height: 24),
            UserInfoCard(),
            SizedBox(height: 24),
            ProjectsStatsCard(),
            SizedBox(height: 24),
            ProjectList(),
          ],
        ),
      ),
    );
  }
}