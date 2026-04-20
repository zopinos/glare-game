import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glare_game/screens/level_screen.dart';
import 'package:glare_game/styling/sizes.dart';
import 'package:glare_game/styling/typography.dart';
import 'package:glare_game/widgets/base_page.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Glare", style: TextStyle(fontSize: FontSizes.xxl)),
            Padding(padding: EdgeInsets.all(Paddings.defaultPadding)),
            ElevatedButton(
              child: Text("Start", style: TextStyle(fontSize: FontSizes.base)),
              onPressed: () => Get.to(() => LevelScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
