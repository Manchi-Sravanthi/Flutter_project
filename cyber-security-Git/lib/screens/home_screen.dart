import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // We'll keep a scale map for independent button animations
  final Map<String, double> _buttonScales = {
    'learn': 1.0,
    'survey': 1.0,
    'spamcheck': 1.0,
  };

  void _onTapDown(String key) {
    setState(() => _buttonScales[key] = 0.95);
  }

  void _onTapUp(String key) {
    setState(() => _buttonScales[key] = 1.0);
  }

  Widget buildFancyButton({
    required String keyName,
    required IconData icon,
    required String text,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTapDown: (_) => _onTapDown(keyName),
      onTapUp: (_) => _onTapUp(keyName),
      onTapCancel: () => _onTapUp(keyName),
      onTap: onTap,
      child: AnimatedScale(
        scale: _buttonScales[keyName]!,
        duration: const Duration(milliseconds: 150),
        child: Container(
          width: double.infinity,
          height: 65,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: gradientColors.last.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(18),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: onTap,
              splashColor: Colors.white24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2196F3), Color(0xFF21CBF3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                const Icon(
                  Icons.security,
                  size: 150,
                  color: Colors.white,
                ),
                const SizedBox(height: 30),

                // Title
                const Text(
                  "Explore Cyber Safety Tools",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  "Stay safe online with knowledge and tools.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 50),

                // Buttons
                buildFancyButton(
                  keyName: 'learn',
                  icon: Icons.book,
                  text: "Learn",
                  gradientColors: [Colors.blue, Colors.indigo],
                  onTap: () => Navigator.pushNamed(context, '/learn'),
                ),
                const SizedBox(height: 20),

                buildFancyButton(
                  keyName: 'survey',
                  icon: Icons.assignment,
                  text: "Survey",
                  gradientColors: [Colors.green, Colors.teal],
                  onTap: () => Navigator.pushNamed(context, '/survey'),
                ),
                const SizedBox(height: 20),

                buildFancyButton(
                  keyName: 'spamcheck',
                  icon: Icons.report,
                  text: "Spam Number Checker",
                  gradientColors: [Colors.red, Colors.deepOrange],
                  onTap: () => Navigator.pushNamed(context, '/spamcheck'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
