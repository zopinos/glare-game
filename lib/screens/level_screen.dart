import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glare_game/screens/game_screen.dart';
import 'package:glare_game/screens/start_screen.dart';
import 'package:glare_game/services/level_service.dart';

class LevelScreen extends StatelessWidget {
  final levelService = Get.find<LevelService>();

  LevelScreen({super.key});

  bool levelAvailable(int level) {
    return levelService.completedLevels.contains(level - 1) || level == 0;
  }

  @override
  Widget build(BuildContext context) {
    final levels = Iterable.generate(levelService.totalLevels).expand((level) {
      return [
        Padding(padding: EdgeInsets.all(16)),
        ElevatedButton(
          onPressed: levelAvailable(level)
              ? () {
                  levelService.currentLevel = level;
                  Get.to(() => GameScreen());
                }
              : null,
          child: Text(
            "Level ${level + 1} (${levelAvailable(level) ? (levelService.completedLevels.contains(level) ? "Completed, High Score: ${levelService.levelScores[level] ?? 0}" : "Not completed") : "Not available"})",
            style: TextStyle(fontSize: 24),
          ),
        ),
      ];
    }).toList();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Choose a level", style: TextStyle(fontSize: 48)),
            ...levels,
            Padding(padding: EdgeInsets.all(16)),
            ElevatedButton(
              child: Text("Back to Start", style: TextStyle(fontSize: 24)),
              onPressed: () => Get.to(StartScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
