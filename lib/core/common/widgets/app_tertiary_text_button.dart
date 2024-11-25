import 'package:cafedating/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppTertiaryTextButton extends StatelessWidget {
  final String label;
  final ButtonStyle? buttonStyle;
  final VoidCallback? onPressed;
  const AppTertiaryTextButton({
    super.key,
    required this.label,
    this.buttonStyle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
            color: isLightTheme
                ? AppTheme.tertiaryColor
                : AppTheme.darkTertiaryContainerColor),
      ),
    );
  }
}
