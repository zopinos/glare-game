import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:glare_game/constants/config.dart';

class Ball extends BodyComponent with DragCallbacks {
  Ball(Vector2 position)
    : super(
        renderBody: false,
        bodyDef: BodyDef()
          ..position = position
          ..type = BodyType.static
          ..angularDamping = 0.1
          ..linearDamping = 0.1,
        fixtureDefs: [
          FixtureDef(CircleShape()..radius = ballSize / 2)
            ..restitution = 0.4
            ..density = 0.75
            ..friction = 0.5,
        ],
      );

  @override
  Future<void> onLoad() {
    addAll([
      CustomPainterComponent(
        painter: _DragPainter(this),
        anchor: Anchor.center,
        size: Vector2(ballSize, ballSize),
        position: Vector2(0, 0),
      ),
      CircleComponent(
        radius: ballSize / 2,
        anchor: Anchor.center,
        paint: Paint()..color = Colors.white,
      ),
    ]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!body.isAwake) {
      removeFromParent();
    }

    if (position.x > camera.visibleWorldRect.right + 10 ||
        position.x < camera.visibleWorldRect.left - 10) {
      removeFromParent();
    }
  }

  Vector2 _dragStart = Vector2.zero();
  Vector2 _dragDelta = Vector2.zero();
  Vector2 get dragDelta => _dragDelta;

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    if (body.bodyType == BodyType.static) {
      _dragStart = event.localPosition;
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (body.bodyType == BodyType.static) {
      _dragDelta = event.localEndPosition - _dragStart;
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    if (body.bodyType == BodyType.static) {
      children
          .whereType<CustomPainterComponent>()
          .firstOrNull
          ?.removeFromParent();
      body.setType(BodyType.dynamic);
      body.applyLinearImpulse(_dragDelta * -50);
      add(RemoveEffect(delay: 5.0));
    }
  }
}

extension on String {
  String get capitalize =>
      characters.first.toUpperCase() + characters.skip(1).toLowerCase().join();
}

class _DragPainter extends CustomPainter {
  _DragPainter(this.player);

  final Ball player;

  @override
  void paint(Canvas canvas, Size size) {
    if (player.dragDelta != Vector2.zero()) {
      var center = size.center(Offset.zero);
      canvas.drawLine(
        center,
        center + (player.dragDelta * -1).toOffset(),
        Paint()
          ..color = Colors.orange.withAlpha(180)
          ..strokeWidth = 0.4
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
