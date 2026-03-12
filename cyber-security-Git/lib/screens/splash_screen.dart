import 'dart:io';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _position = 0.0;

  void _onDragUpdate(DragUpdateDetails details, BoxConstraints constraints) {
    setState(() {
      _position += details.primaryDelta!;
      _position = _position.clamp(-constraints.maxWidth / 2, constraints.maxWidth / 2);
    });
  }

  void _onDragEnd(BoxConstraints constraints) {
    if (_position > constraints.maxWidth / 4) {
      Navigator.pushReplacementNamed(context, '/home'); // Swipe right → continue
    } else if (_position < -constraints.maxWidth / 4) {
      exit(0); // Swipe left → exit app
    } else {
      setState(() {
        _position = 0.0; // Reset to center
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            color: Colors.blueAccent.shade700,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // --- Top Section: Logo + Text ---
                Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: Column(
                    children: const [
                      Icon(
                        Icons.security,
                        size: 200,
                        color: Colors.white,
                      ),
                      SizedBox(height: 100),
                      Text(
                        "CYBER SAFETY",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),

                // --- Bottom Section: Swipe Control ---
                Padding(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) => _onDragUpdate(details, constraints),
                    onHorizontalDragEnd: (_) => _onDragEnd(constraints),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Track with labels
                        Container(
                          width: constraints.maxWidth * 0.75,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "Exit",
                                  style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  "Continue",
                                  style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Movable pill slider
                        LayoutBuilder(
                          builder: (context, innerConstraints) {
                            final trackWidth = constraints.maxWidth * 0.75;
                            final pillWidth = 80.0;
                            final center = (trackWidth - pillWidth) / 2;

                            return AnimatedPositioned(
                              duration: const Duration(milliseconds: 200),
                              left: (constraints.maxWidth - trackWidth) / 2 + center + _position,
                              child: Container(
                                width: pillWidth,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 8,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
                              ),
                            );
                          },
                        ),
                      ],
                    )

                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
