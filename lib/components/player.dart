import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/contact_callbacks.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:glare_game/game/glare_game.dart';

class Player extends BodyComponent<GlareGame>
    with TapCallbacks, ContactCallbacks {
  Player(Vector2 position)
    : super(
        bodyDef: BodyDef()
          ..position = position
          ..type = BodyType.dynamic
          ..angularVelocity = 0.0,
        fixtureDefs: [
          FixtureDef(PolygonShape()..setAsBoxXY(2.5, 2.5))..restitution = 0.75,
        ],
      );

  void move(Vector2 impulse) {
    body.linearVelocity = Vector2.zero();
    body.applyLinearImpulse(impulse);
  }
}
