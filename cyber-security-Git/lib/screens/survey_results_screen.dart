import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SurveyResultsScreen extends StatefulWidget {
  const SurveyResultsScreen({super.key});

  @override
  State<SurveyResultsScreen> createState() => _SurveyResultsScreenState();
}

class _SurveyResultsScreenState extends State<SurveyResultsScreen> {
  List<Map<String, dynamic>> surveys = [];

  @override
  void initState() {
    super.initState();
    loadSurveys();
  }

  Future<void> loadSurveys() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList("surveys") ?? [];
    setState(() {
      surveys = saved.map((s) => jsonDecode(s) as Map<String, dynamic>).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Survey Results")),
      body: surveys.isEmpty
          ? const Center(child: Text("No surveys submitted yet."))
          : ListView.builder(
        itemCount: surveys.length,
        itemBuilder: (context, index) {
          final survey = surveys[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text("Fraud Faced: ${survey["cyberFraud"]}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Training Mode: ${survey["trainingMode"]}"),
                  Text("Feedback: ${survey["feedback"]}"),
                  Text("Time: ${survey["time"]}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
