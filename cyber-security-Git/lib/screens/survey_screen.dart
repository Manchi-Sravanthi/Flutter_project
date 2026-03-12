import 'package:flutter/material.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  String? awarenessLevel;
  String? experiencedCyberThreat;

  void submitSurvey() {
    String name = nameController.text;
    String age = ageController.text;
    String feedback = feedbackController.text;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Survey Submitted!\nName: $name\nAge: $age\nAwareness: $awarenessLevel\nExperienced Threat: $experiencedCyberThreat\nFeedback: $feedback",
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cyber Safety Survey"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Icon(Icons.assignment, size: 50, color: Colors.blueGrey),
            const SizedBox(height: 10),
            const Text(
              "Help us improve Cyber Safety",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Name
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Your Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: const Icon(Icons.person, color: Colors.blue),
                  ),
                ),
              ),
            ),



            const SizedBox(height: 20),

            // Awareness Level Dropdown
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Cyber Safety Awareness Level",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon:
                    const Icon(Icons.security, color: Colors.green),
                  ),
                  items: const [
                    DropdownMenuItem(value: "High", child: Text("High")),
                    DropdownMenuItem(value: "Medium", child: Text("Medium")),
                    DropdownMenuItem(value: "Low", child: Text("Low")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      awarenessLevel = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Experienced Cyber Threat Dropdown
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Have you experienced a cyber threat?",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon:
                    const Icon(Icons.warning, color: Colors.orange),
                  ),
                  items: const [
                    DropdownMenuItem(value: "Yes", child: Text("Yes")),
                    DropdownMenuItem(value: "No", child: Text("No")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      experiencedCyberThreat = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Feedback
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: feedbackController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: "Your Feedback",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon:
                    const Icon(Icons.feedback, color: Colors.deepOrange),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // ✅ Submit Button inside the form (NOT navigation bar)
            ElevatedButton.icon(
              onPressed: submitSurvey,
              icon: const Icon(Icons.send),
              label: const Text("Submit"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
