import 'package:flutter/material.dart';

class AppTextTitleLarge extends StatelessWidget {
  final String text;
  const AppTextTitleLarge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 22,
          letterSpacing: 0,
          height: 1.3),
    );
  }
}
