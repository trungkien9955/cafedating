import 'package:flutter/material.dart';

class AppTextBodyMedium extends StatelessWidget {
  final String text;
  const AppTextBodyMedium({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: 0.25,
          height: 1.4),
    );
  }
}
