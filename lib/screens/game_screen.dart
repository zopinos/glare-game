import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:glare_game/game/glare_game.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: GlareGame());
  }
}
