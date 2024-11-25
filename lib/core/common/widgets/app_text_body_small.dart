import 'package:flutter/material.dart';

class AppTextBodySmall extends StatelessWidget {
  final String text;
  const AppTextBodySmall({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          letterSpacing: 0.4,
          height: 1.3),
    );
  }
}
