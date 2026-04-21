import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:glare_game/constants/config.dart';
import 'package:glare_game/game/glare_game.dart';

class ScoreIndicator extends TextComponent with HasGameReference<GlareGame> {
  ScoreIndicator({
    required Vector2 position,
    required String text,
    required Color color,
  }) : super(
         position: position,
         text: text,
         anchor: Anchor.center,
         textRenderer: TextPaint(
           style: TextStyle(color: color, fontSize: scoreIndicatorTextSize),
         ),
       );

  var timeSinceSpawn = 0.0;

  @override
  void update(double dt) {
    super.update(dt);
    timeSinceSpawn += dt;
    if (timeSinceSpawn > scoreIndicatorLifeTime) {
      removeFromParent();
    }
  }
}
