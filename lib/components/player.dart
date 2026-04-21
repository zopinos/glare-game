import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:glare_game/constants/config.dart';
import 'package:glare_game/game/glare_game.dart';

class Player extends BodyComponent<GlareGame>
    with TapCallbacks, ContactCallbacks {
  Player({required this.position}) : super();

  @override
  final Vector2 position;

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      position: position,
      type: BodyType.dynamic,
      angularDamping: playerAngularDamping,
      userData: this,
    );

    final shape = PolygonShape()..setAsBoxXY(playerSize, playerSize);
    final fixtureDef = FixtureDef(shape)..restitution = playerBounciness;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  void move(Vector2 impulse) {
    if (impulse.length < minImpulseForce) return;

    impulse.clampLength(minImpulseForce, maxImpulseForce);
    body.linearVelocity = Vector2.zero();

    body.applyLinearImpulse(impulse * playerMoveFactor);
  }
}
