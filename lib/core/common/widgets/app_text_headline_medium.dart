import 'package:flutter/material.dart';

class AppTextHeadlineMedium extends StatelessWidget {
  final String text;
  const AppTextHeadlineMedium({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 28,
          letterSpacing: 0,
          height: 1.2),
    );
  }
}
