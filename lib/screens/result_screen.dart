import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glare_game/screens/start_screen.dart';
import 'package:glare_game/styling/sizes.dart';
import 'package:glare_game/styling/typography.dart';
import 'package:glare_game/widgets/base_page.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.score,
    required this.scoreRequirement,
    required this.levelCompleted,
    required this.isHighScore,
    required this.level,
  });

  final int score;
  final int scoreRequirement;
  final bool levelCompleted;
  final bool isHighScore;
  final int level;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: Margins.largeMargin),
              child: Text(
                textAlign: TextAlign.center,
                levelCompleted
                    ? "Great work, Level ${level + 1} completed! You got $score/$scoreRequirement points!"
                    : "Not quite, you got $score/$scoreRequirement points. Try again!",
                style: TextStyle(fontSize: FontSizes.xl),
              ),
            ),
            levelCompleted && isHighScore
                ? Padding(padding: EdgeInsets.all(Paddings.compactPadding))
                : Container(),
            levelCompleted && isHighScore
                ? Text(
                    textAlign: TextAlign.center,
                    "New high score!",
                    style: TextStyle(fontSize: FontSizes.lg),
                  )
                : Container(),
            Padding(padding: EdgeInsets.all(Paddings.defaultPadding)),
            ElevatedButton(
              child: Text(
                "Back to start",
                style: TextStyle(fontSize: FontSizes.base),
              ),
              onPressed: () => Get.to(() => StartScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
