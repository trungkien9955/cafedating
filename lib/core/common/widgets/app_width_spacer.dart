import 'package:flutter/material.dart';

class AppWidthSpacer extends StatelessWidget {
  final double width;
  const AppWidthSpacer({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: width);
  }
}
