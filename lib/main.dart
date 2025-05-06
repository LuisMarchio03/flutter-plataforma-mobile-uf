import 'package:flutter/material.dart';
import 'package:myapp/ui/screens/project_details.dart';
import 'package:myapp/ui/screens/project_details_not_register.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projeto Hub',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D0F1B),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white), 
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      initialRoute: '/',
      routes: {
        // '/': (context) => const LoginScreen(),
        '/': (context) => const ProjectDetails(),
        '/home': (context) => const DashboardScreen(),
        '/project/details/not_registered': (context) => const ProjectDetailsNotRegister(),
        '/project/details': (context) => const ProjectDetails(),
      },
    );
  }
}
