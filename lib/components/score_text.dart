import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:glare_game/constants/config.dart';
import 'package:glare_game/game/glare_game.dart';

class ScoreText extends PositionComponent with HasGameReference<GlareGame> {
  ScoreText({required Vector2 position}) : super(position: position);

  late final ValueNotifier<int> scoreNotifier = game.scoreNotifier;
  late final TextComponent _scoreComponent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final scoreText = TextComponent(
      position: Vector2.zero(),
      anchor: Anchor.center,
    );
    add(scoreText);
    void updateLapText() {
      scoreText.text =
          "Score: ${scoreNotifier.value}/${scoreRequirements[game.currentLevel]}";
    }

    _scoreComponent = TextComponent(
      position: Vector2(0, 70),
      anchor: Anchor.center,
    );
    add(_scoreComponent);

    scoreNotifier.addListener(updateLapText);
    updateLapText();
  }
}
