import 'package:flutter/material.dart';

class AppTextHeadlineLarge extends StatelessWidget {
  final String text;
  const AppTextHeadlineLarge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.w400, fontSize: 32, letterSpacing: 0),
    );
  }
}
