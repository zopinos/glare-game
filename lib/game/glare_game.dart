import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:get/get.dart';
import 'package:glare_game/components/game_bounds.dart';
import 'package:glare_game/components/hittable.dart';
import 'package:glare_game/components/player.dart';
import 'package:glare_game/constants/config.dart';
import 'package:glare_game/screens/result_screen.dart';
import 'package:glare_game/services/level_service.dart';

class GlareGame extends Forge2DGame with PanDetector {
  final levelService = Get.find<LevelService>();
  final random = Random();

  var gameFinished = false;

  double get width => size.x;
  double get height => size.y;

  late Player player;

  Vector2? dragVelocity;

  var timeLeft = 30.0;
  var score = 0;

  late double spawnFrequency;
  var timeSinceLastSpawn = 0.0;

  late Rect gameRect;
  late double leftLocation;
  late double rightLocation;
  late double topLocation;
  late double bottomLocation;

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

    gameRect = camera.visibleWorldRect;
    leftLocation = 0.0;
    rightLocation = gameRect.width;
    topLocation = 0.0;
    bottomLocation = gameRect.height;

    spawnFrequency = spawnFrequencies[levelService.currentLevel];

    camera.viewfinder.anchor = Anchor.topLeft;

    //final viewport = camera.viewport as FixedResolutionViewport;

    //viewport.add(TextComponent(text: "hello world", position: Vector2.zero()));

    world.add(FinishLevelRectangle());

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
      _spawnHittable();
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

  void _spawnHittable() {
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

    print(
      "randomValue: $randomValue, spawnLocation: $spawnLocation, initialVelocity: $initialVelocity",
    );

    world.add(Hittable(position: spawnLocation, velocity: initialVelocity));
  }

  void _finishGame() {
    gameFinished = true;
    levelService.completedLevels.add(levelService.currentLevel);
    Get.offAll(() => ResultScreen(score: score));
  }

  void completeGame() {
    if (!gameFinished) {
      _finishGame();
    }
  }
}

class FinishLevelRectangle extends RectangleComponent
    with HasGameRef<GlareGame>, TapCallbacks {
  FinishLevelRectangle()
    : super(position: Vector2(1.0, 1.0), size: Vector2(2.0, 2.0));

  @override
  void onTapDown(TapDownEvent event) {
    gameRef.completeGame();
  }
}
