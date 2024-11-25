import 'package:cafedating/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final Color? bgColor;
  final bool hasBgColor;
  const AppCard(
      {super.key, required this.child, this.bgColor, required this.hasBgColor});

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;

    return SizedBox(
      width: double.infinity,
      child: Card.filled(
        color: hasBgColor ? bgColor : null,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: child,
        ),
      ),
    );
  }
}
