import 'package:flutter/material.dart';
import 'package:glare_game/styling/sizes.dart';

class BasePage extends StatelessWidget {
  const BasePage({required this.body, super.key});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Widths.maxWidth,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: Paddings.largePadding),
            child: body,
          ),
        ),
      ),
    );
  }
}
