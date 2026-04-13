import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:glare_game/constants/config.dart';

class Board extends PositionComponent {
  Board({required super.position}) : super();

  @override
  Future<void> onLoad() async {
    addAll([
      CircleComponent(
        position: position,
        radius: boardWidth / 2,
        paint: Paint()..color = const Color.fromARGB(255, 214, 154, 97),
      ),
      RectangleComponent(
        position: Vector2(position.x, position.y + boardWidth / 2),
        size: Vector2(boardWidth, boardWidth * 1.4),
        paint: Paint()..color = const Color.fromARGB(255, 214, 154, 97),
      ),
    ]);
    return super.onLoad();
  }
}
