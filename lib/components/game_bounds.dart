import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class GameBounds extends BodyComponent {
  @override
  Body createBody() {
    final bodyDef = BodyDef(
      type: BodyType.static,
      position: Vector2.zero(),
      userData: this,
    );

    Body gameBoundsBody = world.createBody(bodyDef);

    final gameRect = game.camera.visibleWorldRect;
    final gameBoundsVectors = [
      gameRect.topLeft.toVector2() + Vector2(1, 1),
      gameRect.topRight.toVector2() + Vector2(-1, 1),
      gameRect.bottomRight.toVector2() + Vector2(-1, -1),
      gameRect.bottomLeft.toVector2() + Vector2(1, -1),
    ];

    for (int i = 0; i < gameBoundsVectors.length; i++) {
      gameBoundsBody.createFixture(
        FixtureDef(
          EdgeShape()..set(
            gameBoundsVectors[i],
            gameBoundsVectors[(i + 1) % gameBoundsVectors.length],
          ),
        ),
      );
    }

    return gameBoundsBody;
  }
}
