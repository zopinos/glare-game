import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glare_game/game/notes_game.dart';

class ComponentWidgetExample extends StatelessWidget {
  const ComponentWidgetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget<NotesGame>(
      game: NotesGame(),
      overlayBuilderMap: {
        'button1': (ctx, game) {
          return ComponentButtonWidget(game, game.createComponentId(1));
        },
      },
      initialActiveOverlays: const ['button1'],
    );
  }
}

class ComponentButtonWidget extends StatefulWidget {
  final NotesGame _game;
  final int _componentId;

  const ComponentButtonWidget(this._game, this._componentId, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _ComponentButtonState(_game, _componentId);
  }
}

class _ComponentButtonState extends State<ComponentButtonWidget> {
  final NotesGame _game;
  final int _componentId;
  PositionComponent? _component;

  _ComponentButtonState(this._game, this._componentId) {
    _game.updateStates.add(() {
      setState(() {
        _component = _game.componentIdMap[_componentId];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final component = _component;
    if (component == null) {
      return Container();
    } else {
      final componentPosition = component.position;
      return Positioned(
        top: componentPosition.y - 18,
        left: componentPosition.x - 90,
        child: Transform.rotate(
          angle: component.angle,
          child: ElevatedButton(
            onPressed: () {
              setState(() => print("component pressed"));
            },
            child: const Text(
              'Widget button!',
              textScaler: TextScaler.linear(2.0),
            ),
          ),
        ),
      );
    }
  }
}
