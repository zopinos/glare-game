import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:get/get.dart';
import 'package:glare_game/components/turret.dart';
import 'package:glare_game/config.dart';
import 'package:glare_game/screens/result_screen.dart';
import 'package:glare_game/services/level_service.dart';

class NotesGame extends FlameGame {
  final levelService = Get.find<LevelService>();

  final List<void Function()> updateStates = [];
  final Map<int, PositionComponent> componentIdMap = {};
  final List<int> addLaterIds = [];

  var gameFinished = false;

  double get width => size.x;
  double get height => size.y;

  NotesGame()
    : super(
        camera: CameraComponent.withFixedResolution(
          width: gameWidth,
          height: gameHeight,
        ),
      );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(
      Turret(
        size: Vector2(turretSize, turretSize),
        position: Vector2(width / 2, width / 2),
      ),
    );
    world.add(TapRectangle());
  }

  @override
  void update(double dt) {
    super.update(dt);
    addLaterIds.forEach((id) {
      if (!componentIdMap.containsKey(id)) {
        componentIdMap[id] = createComponent();
      }
    });
    addLaterIds.clear();
    updateStates.forEach((f) => f());
  }

  int createComponentId(int id) {
    addLaterIds.add(id);
    return id;
  }

  PositionComponent createComponent() {
    final component = RectangleComponent(
      position: Vector2.zero(),
      size: Vector2(50, 50),
      anchor: Anchor.center,
    );
    world.add(component);
    return component;
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
    with HasGameRef<NotesGame>, TapCallbacks {
  TapRectangle()
    : super(
        position: Vector2(100, 100),
        size: Vector2(50, 50),
        anchor: Anchor.center,
      );

  @override
  void onTapDown(TapDownEvent event) {
    gameRef.completeGame();
  }
}
