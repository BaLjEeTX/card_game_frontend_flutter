import 'dart:async';
import 'package:flutter/material.dart';

class FlashScreen extends StatefulWidget {
  final String playerName;

  const FlashScreen({super.key, required this.playerName});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true); // This makes the animation pulse in and out

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // After 4 seconds, automatically close this screen
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // A dark background for dramatic effect
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ScaleTransition(
            // Animate the text size
            scale: _animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Congratulations!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  widget.playerName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'has won the honorable chance to perform a task!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
