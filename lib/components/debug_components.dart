import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:glare_game/game/glare_game.dart';

class FinishLevelRectangle extends RectangleComponent
    with HasGameRef<GlareGame>, TapCallbacks {
  FinishLevelRectangle()
    : super(position: Vector2(1.0, 1.0), size: Vector2(2.0, 2.0));

  @override
  void onTapDown(TapDownEvent event) {
    gameRef.completeGame();
  }
}
