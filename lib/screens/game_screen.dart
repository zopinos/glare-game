import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:glare_game/constants/config.dart';
import 'package:glare_game/game/glare_game.dart';
import 'package:glare_game/widgets/responsive_widget.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: GameWidget(game: GlareGame(mobileGameWidth, mobileGameHeight)),
      desktop: GameWidget(game: GlareGame(desktopGameWidth, desktopGameHeight)),
    );
  }
}
