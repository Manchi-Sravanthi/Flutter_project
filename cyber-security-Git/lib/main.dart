import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/learn_screen.dart';
import 'screens/survey_screen.dart';
import 'screens/spam_checker.dart';
import 'screens/survey_results_screen.dart';

void main() {
  runApp(const CyberSafetyApp());
}

class CyberSafetyApp extends StatelessWidget {
  const CyberSafetyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cyber Safety App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),

routes: {
  '/home': (context) => const HomeScreen(),
  '/learn': (context) => const LearnScreen(),
  '/survey': (context) => const SurveyScreen(),
  '/spamcheck': (context) => const SpamCheckScreen(),
  '/survey_results': (context) => const SurveyResultsScreen(),
}
    );
  }
}
