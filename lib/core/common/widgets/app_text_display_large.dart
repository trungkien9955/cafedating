import 'package:flutter/material.dart';

class AppTextDisplayLarge extends StatelessWidget {
  final String text;
  const AppTextDisplayLarge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 57,
        letterSpacing: -0.25,
        // height: 64
      ),
    );
  }
}
