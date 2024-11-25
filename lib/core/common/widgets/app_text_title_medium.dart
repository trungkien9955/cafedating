import 'package:flutter/material.dart';

class AppTextTitleMedium extends StatelessWidget {
  final String text;
  const AppTextTitleMedium({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          letterSpacing: 0.15,
          height: 1.5),
    );
  }
}
