import 'package:flutter/material.dart';

class GameScaffold extends StatelessWidget {
  final List<Widget> content;
  const GameScaffold({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: content,
        ),
      ),
    );
  }
}
