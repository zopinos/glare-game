import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:glare_game/components/debug_components.dart';
import 'package:glare_game/components/enemy.dart';
import 'package:glare_game/components/game_bounds.dart';
import 'package:glare_game/components/hittable.dart';
import 'package:glare_game/components/player.dart';
import 'package:glare_game/components/score_text.dart';
import 'package:glare_game/constants/config.dart';
import 'package:glare_game/controllers/level_controller.dart';
import 'package:glare_game/screens/result_screen.dart';

class GlareGame extends Forge2DGame with PanDetector {
  final levelController = Get.find<LevelController>();
  final random = Random();

  var gameFinished = false;

  double get width => size.x;
  double get height => size.y;
  int get currentLevel => levelController.currentLevel;

  late Player player;

  Vector2? dragVelocity;

  var timeLeft = gameTimeLength;
  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);

  late double spawnFrequency;
  var timeSinceLastSpawn = 0.0;

  late Rect gameRect;
  late double leftLocation;
  late double rightLocation;
  late double topLocation;
  late double bottomLocation;

  GlareGame(double gameWidth, double gameHeight)
    : super(
        gravity: Vector2(0, gravity),
        camera: CameraComponent.withFixedResolution(
          width: gameWidth,
          height: gameHeight,
        ),
      );

  @override
  Color backgroundColor() => gameBackgroundColor;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    gameRect = camera.visibleWorldRect;
    leftLocation = 0.0;
    rightLocation = gameRect.width;
    topLocation = 0.0;
    bottomLocation = gameRect.height;

    spawnFrequency = spawnFrequencies[currentLevel];

    camera.viewfinder.anchor = Anchor.topLeft;

    final scoreText = ScoreText(
      position: Vector2(
        camera.viewport.virtualSize.x / 2,
        camera.viewport.virtualSize.y / 16,
      ),
    );
    camera.viewport.add(scoreText);

    if (debug) {
      world.add(FinishLevelRectangle());
    }

    world.add(GameBounds());

    player = Player(position: gameRect.bottomRight.toVector2());
    world.add(player);
  }

  @override
  void update(double dt) {
    super.update(dt);

    timeLeft -= dt;

    if (timeLeft <= 0 && !gameFinished) {
      _finishGame();
    }

    timeSinceLastSpawn += dt;
    if (timeSinceLastSpawn > spawnFrequency) {
      final entityType = random.nextDouble() < spawnRates[currentLevel]
          ? entityTypes[0]
          : entityTypes[1];
      _spawnEntity(entityType);
      timeSinceLastSpawn = 0.0;
    }
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

  void _spawnEntity(String entityType) {
    final randomValue = random.nextDouble();

    Vector2 spawnLocation;
    Vector2 initialVelocity;

    if (randomValue < 0.25) {
      spawnLocation = Vector2(
        leftLocation +
            spawnOffset +
            random.nextDouble() *
                (rightLocation - spawnOffset * 2 - leftLocation),
        topLocation,
      );
      initialVelocity = Vector2(0.0, 1.0) * hittableMaxSpeed;
    } else if (randomValue < 0.50) {
      spawnLocation = Vector2(
        rightLocation,
        topLocation +
            spawnOffset +
            random.nextDouble() *
                (bottomLocation - spawnOffset * 2 - topLocation),
      );
      initialVelocity = Vector2(-1.0, 0.0) * hittableMaxSpeed;
    } else if (randomValue < 0.75) {
      spawnLocation = Vector2(
        leftLocation +
            spawnOffset +
            random.nextDouble() *
                (rightLocation - spawnOffset * 2 - leftLocation),
        bottomLocation,
      );
      initialVelocity = Vector2(0.0, -1.0) * hittableMaxSpeed;
    } else {
      spawnLocation = Vector2(
        leftLocation,
        topLocation +
            spawnOffset +
            random.nextDouble() *
                (bottomLocation - spawnOffset * 2 - topLocation),
      );
      initialVelocity = Vector2(1.0, 0.0) * hittableMaxSpeed;
    }

    if (entityType == "hittable") {
      world.add(Hittable(position: spawnLocation, velocity: initialVelocity));
    } else if (entityType == "enemy") {
      world.add(Enemy(position: spawnLocation, velocity: initialVelocity));
    }
  }

  void _finishGame() {
    gameFinished = true;

    if (scoreNotifier.value >= scoreRequirements[currentLevel]) {
      levelController.markLevelCompleted(currentLevel);
    }

    final currentBestScore = levelController.getLevelScore(currentLevel) ?? 0;
    if (scoreNotifier.value > currentBestScore) {
      levelController.updateLevelScore(currentLevel, scoreNotifier.value);
    }

    Get.offAll(
      () => ResultScreen(
        score: scoreNotifier.value,
        scoreRequirement: scoreRequirements[currentLevel],
        levelCompleted: scoreNotifier.value >= scoreRequirements[currentLevel],
        isHighScore: scoreNotifier.value > currentBestScore,
        level: currentLevel,
      ),
    );
  }

  void completeGame() {
    if (!gameFinished) {
      _finishGame();
    }
  }
}
