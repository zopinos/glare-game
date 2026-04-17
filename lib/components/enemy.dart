import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:glare_game/constants/config.dart';
import 'package:glare_game/game/glare_game.dart';
import 'dart:ui';

class Enemy extends BodyComponent<GlareGame> with ContactCallbacks {
  Enemy({required this.position, required this.velocity}) : super();

  @override
  final Vector2 position;
  final Vector2 velocity;
  final Paint paint = Paint()..color = const Color.fromARGB(255, 255, 64, 64);

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      position: position,
      linearVelocity: velocity,
      type: BodyType.kinematic,
      userData: this,
    );

    final shape = PolygonShape()..setAsBoxXY(hittableSize, hittableSize);
    final fixtureDef = FixtureDef(shape)..restitution = 0.0;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset.zero,
        width: hittableSize * 2,
        height: hittableSize * 2,
      ),
      paint,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (body.position.x < game.leftLocation ||
        body.position.x > game.rightLocation ||
        body.position.y < game.topLocation ||
        body.position.y > game.bottomLocation) {
      removeFromParent();
    }
  }

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);
    if (game.scoreNotifier.value > 0) {
      game.scoreNotifier.value -= 1;
    }
    removeFromParent();
  }
}
