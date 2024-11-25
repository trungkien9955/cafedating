import 'package:cafedating/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppSecondaryFilledButton extends StatelessWidget {
  final String label;
  final ButtonStyle? buttonStyle;
  final VoidCallback? onPressed;
  const AppSecondaryFilledButton({
    super.key,
    required this.label,
    this.buttonStyle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: isLightTheme
              ? WidgetStatePropertyAll(AppTheme.secondaryContainerColor)
              : WidgetStatePropertyAll(AppTheme.darkSecondaryContainerColor)),
      child: Text(
        label,
        style: TextStyle(
            color: isLightTheme
                ? AppTheme.onSecondaryContainerColor
                : AppTheme.darkOnSecondaryContainerColor),
      ),
    );
  }
}
