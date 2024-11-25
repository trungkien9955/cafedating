import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String label;
  final Color? color;
  const AppTextButton(
      {super.key, this.onPress, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPress,
        child: Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11,
              letterSpacing: 0.5,
              height: 1.5,
              color: color),
        ));
  }
}
