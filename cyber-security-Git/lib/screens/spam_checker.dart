import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // for rootBundle

class SpamCheckScreen extends StatefulWidget {
  const SpamCheckScreen({super.key});

  @override
  State<SpamCheckScreen> createState() => _SpamCheckScreenState();
}

class _SpamCheckScreenState extends State<SpamCheckScreen> {
  final TextEditingController _numberController = TextEditingController();

  String _result = "";
  bool _loading = false;

  List<String> spamNumbers = [];

  @override
  void initState() {
    super.initState();
    loadSpamNumbers();
  }

  Future<void> loadSpamNumbers() async {
    try {
      final String response =
      await rootBundle.loadString('assets/spam_numbers_clean.json');
      final List<dynamic> data = json.decode(response);

      setState(() {
        // Normalize numbers: remove spaces, keep digits only
        spamNumbers = data
            .map((e) => e.toString().replaceAll(RegExp(r'\D'), ''))
            .toList();
      });
    } catch (e) {
      setState(() {
        _result = "Error loading spam numbers.";
      });
    }
  }

  void checkNumber() {
    String number = _numberController.text.trim();

    // Normalize input: remove everything except digits
    number = number.replaceAll(RegExp(r'\D'), '');

    setState(() {
      _loading = true;
      _result = "";
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      // Check if number matches full or last 10 digits
      bool isSpam = spamNumbers.any((n) =>
      n == number ||
          (n.length >= 10 && number.length >= 10 && n.endsWith(number)) ||
          (number.length >= 10 && n.length >= 10 && number.endsWith(n)));

      setState(() {
        _loading = false;
        _result = isSpam
            ? "⚠️ This number is reported as SPAM!"
            : "✅ This number seems safe.";
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.lightBlueAccent],
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
              "Spam Number Checker",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 10,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Enter your number to check if it's reported as spam",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _numberController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter phone number",
                    icon: Icon(Icons.phone, color: Colors.blueAccent),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _loading ? null : checkNumber,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text(
                  "Check Number",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 25),
              if (_loading) const Center(child: CircularProgressIndicator()),
              if (_result.isNotEmpty)
                Center(
                  child: Text(
                    _result,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _result.contains("SPAM") ? Colors.red : Colors.green,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
