import 'dart:math';

import 'package:flame/camera.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:get/get.dart';
import 'package:glare_game/screens/result_screen.dart';

class TapGame extends Forge2DGame {
  final gravity = Vector2(0, 100);
  final moveFrequency = 1.0;
  final impulseScale = 5000.0;

  var gameFinished = false;
  var timeLeft = 30.0;
  var score = 0;

  TapGame()
    : super(
        camera: CameraComponent.withFixedResolution(width: 800, height: 600),
      );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    world.add(TapRectangle());
    world.add(GameBounds());
    world.add(TapCircle());
    world.add(TapTriangle());
  }

  @override
  void update(double dt) {
    super.update(dt);
    timeLeft -= dt;

    if (timeLeft <= 0 && !gameFinished) {
      finishGame();
    }
  }

  finishGame() {
    gameFinished = true;
    Get.offAll(() => ResultScreen(score: score));
  }

  incrementScore() {
    score++;
  }
}

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

class TapRectangle extends BodyComponent<TapGame>
    with TapCallbacks, ContactCallbacks {
  final random = Random();
  var timeSinceLastMove = 0.0;
  var velocity = Vector2(0, 0);

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      position: Vector2(0, 0),
      type: BodyType.dynamic,
      angularVelocity: 1.5,
      userData: this,
    );

    final shape = PolygonShape()..setAsBoxXY(2.5, 2.5);
    final fixtureDef = FixtureDef(shape)..restitution = 0.75;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.incrementScore();
    body.applyLinearImpulse(
      Vector2(
            (random.nextDouble() - 0.5),
            (random.nextDouble() - 0.5),
          ).normalized() *
          game.impulseScale,
    );
  }
}

class TapCircle extends TapRectangle {
  @override
  Body createBody() {
    final bodyDef = BodyDef(
      position: Vector2(10, -10),
      type: BodyType.dynamic,
      angularVelocity: 1.5,
      userData: this,
    );

    final shape = CircleShape(
      radius: 2.5,
    ); //PolygonShape()..setAsBoxXY(2.5, 2.5);
    final fixtureDef = FixtureDef(shape)..restitution = 0.75;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class TapTriangle extends TapRectangle {
  @override
  Body createBody() {
    final bodyDef = BodyDef(
      position: Vector2(-10, -10),
      type: BodyType.dynamic,
      userData: this,
    );

    final shape = PolygonShape()
      ..set([
        Vector2(0, 0),
        Vector2(5, 0),
        Vector2(5, 5),
      ]); //..setAsBoxXY(2.5, 2.5);
    final fixtureDef = FixtureDef(shape)..restitution = 0.75;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
