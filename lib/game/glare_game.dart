import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glare_game/components/ball.dart';
import 'package:glare_game/components/board.dart';
import 'package:glare_game/components/game_bounds.dart';
import 'package:glare_game/components/player.dart';
import 'package:glare_game/components/turret.dart';
import 'package:glare_game/constants/config.dart';
import 'package:glare_game/screens/result_screen.dart';
import 'package:glare_game/services/level_service.dart';

class GlareGame extends Forge2DGame with PanDetector {
  final levelService = Get.find<LevelService>();

  var gameFinished = false;

  double get width => size.x;
  double get height => size.y;

  final player = Player(Vector2(10.0, 10.0));

  Vector2? dragVelocity;

  GlareGame()
    : super(
        gravity: Vector2(0, gravity),
        camera: CameraComponent.withFixedResolution(
          width: gameWidth,
          height: gameHeight,
        ),
      );

  @override
  Color backgroundColor() => const Color.fromARGB(255, 20, 20, 20);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    //final viewport = camera.viewport as FixedResolutionViewport;

    //viewport.add(TextComponent(text: "hello world", position: Vector2.zero()));

    world.add(GameBounds());

    world.add(player);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void onPanEnd(DragEndInfo info) {
    dragVelocity = info.velocity;

    _applySwipeImpulse();
  }

  void _applySwipeImpulse() {
    if (dragVelocity == null) return;

    player.move(dragVelocity!);
  }

  finishGame() {
    gameFinished = true;
    levelService.completedLevels.add(levelService.currentLevel);
    Get.offAll(() => ResultScreen(score: 10));
  }

  completeGame() {
    if (!gameFinished) {
      finishGame();
    }
  }
}

class TapRectangle extends RectangleComponent
    with HasGameRef<GlareGame>, TapCallbacks {
  TapRectangle() : super(position: Vector2(100, 100), size: Vector2(50, 50));

  @override
  void onTapDown(TapDownEvent event) {
    gameRef.completeGame();
  }
}
