import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glare_game/screens/game_screen.dart';
import 'package:glare_game/screens/start_screen.dart';
import 'package:glare_game/services/level_service.dart';

class LevelScreen extends StatelessWidget {
  final levelService = Get.find<LevelService>();

  LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final levels = Iterable.generate(levelService.totalLevels).expand((level) {
      return [
        Padding(padding: EdgeInsets.all(16)),
        ElevatedButton(
          child: Text(
            "Level ${level + 1} (${levelService.completedLevels.contains(level) ? "Completed" : "Not completed"})",
            style: TextStyle(fontSize: 24),
          ),
          onPressed: () {
            levelService.currentLevel = level;
            Get.to(() => GameScreen());
          },
        ),
      ];
    }).toList();

    return Scaffold(
      body: Column(
        children: [
          Text("Choose a level", style: TextStyle(fontSize: 48)),
          ...levels,
          Padding(padding: EdgeInsets.all(16)),
          ElevatedButton(
            child: Text("Back to start", style: TextStyle(fontSize: 24)),
            onPressed: () => Get.to(StartScreen()),
          ),
        ],
      ),
    );
  }
}
