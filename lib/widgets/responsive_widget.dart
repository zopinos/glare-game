import 'package:flutter/material.dart';
import 'package:glare_game/styling/sizes.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;
  final bool? useParentWidth;

  const ResponsiveWidget({
    required this.mobile,
    required this.desktop,
    this.useParentWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    if (useParentWidth ?? true) {
      if (screenSize.width < Breakpoints.mobile) {
        return mobile;
      } else {
        return desktop;
      }
    } else {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final maxWidth = constraints.maxWidth;
          if (maxWidth < Breakpoints.mobile) {
            return mobile;
          } else {
            return desktop;
          }
        },
      );
    }
  }
}
