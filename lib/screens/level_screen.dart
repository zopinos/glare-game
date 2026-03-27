import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glare_game/screens/game_screen.dart';
import 'package:glare_game/screens/start_screen.dart';
import 'package:glare_game/services/level_service.dart';
import 'package:glare_game/widgets/game_button.dart';
import 'package:glare_game/widgets/game_scaffold.dart';

class LevelScreen extends StatelessWidget {
  final levelService = Get.find<LevelService>();

  LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final levels = Iterable.generate(levelService.totalLevels).expand((level) {
      return [
        Padding(padding: EdgeInsets.all(16)),
        GameButton(
          text:
              "Level ${level + 1} (${levelService.completedLevels.contains(level) ? "Completed" : "Not completed"})",
          onPressed: () {
            levelService.currentLevel = level;
            Get.to(GameScreen());
          },
        ),
      ];
    }).toList();

    return GameScaffold(
      content: [
        Text("Choose a level", style: TextStyle(fontSize: 48)),
        ...levels,
        Padding(padding: EdgeInsets.all(16)),
        GameButton(
          text: "Back to start",
          onPressed: () => Get.to(StartScreen()),
        ),
      ],
    );
  }
}
