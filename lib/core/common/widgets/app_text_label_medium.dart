import 'package:flutter/material.dart';

class AppTextLabelMedium extends StatelessWidget {
  final String text;
  const AppTextLabelMedium({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          letterSpacing: 0.5,
          height: 1.3),
    );
  }
}
