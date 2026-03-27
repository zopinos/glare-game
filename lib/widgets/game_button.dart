import 'package:flutter/material.dart';

class GameButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const GameButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: Text(text, style: TextStyle(fontSize: 24)),
    );
  }
}
