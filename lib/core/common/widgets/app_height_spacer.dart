import 'package:flutter/material.dart';

class AppHeightSpacer extends StatelessWidget {
  final double height;
  const AppHeightSpacer({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
