import 'package:flutter/material.dart';

class AppTextTitleSmall extends StatelessWidget {
  final String text;
  const AppTextTitleSmall({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: 0.1,
          height: 1.4),
    );
  }
}
