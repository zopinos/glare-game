import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glare_game/screens/start_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int scoreRequirement;
  final bool levelCompleted;
  const ResultScreen({
    super.key,
    required this.score,
    required this.scoreRequirement,
    required this.levelCompleted,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              levelCompleted
                  ? "Great work, you got $score/$scoreRequirement points!"
                  : "Not quite, you got $score/$scoreRequirement points. Try again!",
              style: TextStyle(fontSize: 48),
            ),
            Padding(padding: EdgeInsets.all(16)),
            ElevatedButton(
              child: Text("Back to start", style: TextStyle(fontSize: 24)),
              onPressed: () => Get.to(() => StartScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
