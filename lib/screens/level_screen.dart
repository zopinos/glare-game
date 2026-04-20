import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glare_game/screens/game_screen.dart';
import 'package:glare_game/screens/start_screen.dart';
import 'package:glare_game/services/level_service.dart';
import 'package:glare_game/styling/sizes.dart';
import 'package:glare_game/styling/typography.dart';
import 'package:glare_game/widgets/base_page.dart';
import 'package:glare_game/widgets/responsive_widget.dart';

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
        Container(
          margin: EdgeInsets.all(Margins.compactMargin),
          child: ElevatedButton(
            onPressed: levelAvailable(level)
                ? () {
                    levelService.currentLevel = level;
                    Get.to(() => GameScreen());
                  }
                : null,
            child: Container(
              padding: EdgeInsets.all(Paddings.defaultPadding),
              child: Text(
                textAlign: TextAlign.center,
                "Level ${level + 1} (${levelAvailable(level) ? (levelService.completedLevels.contains(level) ? "Completed, High Score: ${levelService.levelScores[level] ?? 0}" : "Not completed") : "Not available"})",
                style: TextStyle(fontSize: FontSizes.base),
              ),
            ),
          ),
        ),
      ];
    }).toList();

    return BasePage(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(Margins.defaultMargin),
            padding: EdgeInsets.all(Paddings.defaultPadding),
            child: Text(
              textAlign: TextAlign.center,
              "Choose a level",
              style: TextStyle(fontSize: FontSizes.xxl),
            ),
          ),
          ...levels,
          Padding(padding: EdgeInsets.all(Paddings.defaultPadding)),
          ElevatedButton(
            child: Text(
              "Back to Start",
              style: TextStyle(fontSize: FontSizes.base),
            ),
            onPressed: () => Get.to(StartScreen()),
          ),
        ],
      ),
    );
  }
}
