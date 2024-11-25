import 'package:flutter/material.dart';

class AppTextLabelLarge extends StatelessWidget {
  final String text;
  const AppTextLabelLarge({super.key, required this.text});

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
