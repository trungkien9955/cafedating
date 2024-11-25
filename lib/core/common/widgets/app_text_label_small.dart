import 'package:flutter/material.dart';

class AppTextLabelSmall extends StatelessWidget {
  final String text;
  final Color? color;
  const AppTextLabelSmall({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 11,
          letterSpacing: 0.5,
          height: 1.5,
          color: color),
    );
  }
}
