import 'package:cafedating/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppFilledButton2 extends StatelessWidget {
  final String label;
  final ButtonStyle? buttonStyle;
  final VoidCallback? onPressed;
  const AppFilledButton2({
    super.key,
    required this.label,
    this.buttonStyle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      // style: ButtonStyle(
      //     minimumSize: WidgetStatePropertyAll(Size(48, 48)),
      //     backgroundColor: WidgetStatePropertyAll(AppTheme.primaryColor)),
      child: Text(label),
    );
  }
}
