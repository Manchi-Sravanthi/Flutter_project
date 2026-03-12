import 'package:flutter/material.dart';
import 'learn_detail.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  final List<Map<String, dynamic>> topics = const [
    {
      'title': 'Strong Passwords',
      'description':
      'A strong password includes letters, numbers, and symbols. Avoid using personal information like your name or birthday.',
      'icon': Icons.lock,
      'color': Colors.redAccent,
    },
    {
      'title': 'Phishing Awareness',
      'description':
      'Phishing is when attackers trick you into giving sensitive information. Always verify emails and links before clicking.',
      'icon': Icons.email,
      'color': Colors.blueAccent,
    },
    {
      'title': 'Safe Browsing',
      'description':
      'Use secure websites (https://) and avoid downloading files from untrusted sources.',
      'icon': Icons.public,
      'color': Colors.green,
    },
    {
      'title': 'Social Media Safety',
      'description':
      'Limit the personal information you share online. Use privacy settings to control who sees your posts.',
      'icon': Icons.people,
      'color': Colors.orange,
    },
    {
      'title': 'Spam Numbers Awareness',
      'description':
      'Some numbers are often used for spam or scam calls:\n\n'
          '📞 Numbers starting with **140** → Telemarketing calls\n'
          '⚠️ Numbers starting with **1800** → Toll-free (sometimes scams)\n'
          '📲 Very short numbers (4–5 digits) → Promotional SMS\n\n'
          'Be careful before answering such calls.',
      'icon': Icons.phone,
      'color': Colors.purpleAccent,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70, // make appbar taller
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.shield, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "Cyber Safety",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 10,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0), // extra top padding
        child: ListView.builder(
          itemCount: topics.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LearnDetailScreen(
                      title: topics[index]['title'],
                      description: topics[index]['description'],
                      icon: topics[index]['icon'],
                      iconColor: topics[index]['color'],
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 6,
                margin: const EdgeInsets.symmetric(vertical: 12), // spacing between cards
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16), // more space inside
                  leading: Icon(
                    topics[index]['icon'],
                    color: topics[index]['color'],
                    size: 35,
                  ),
                  title: Text(
                    topics[index]['title'],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
