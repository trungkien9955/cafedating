import 'package:flutter/material.dart';

class AppFilledButton extends StatelessWidget {
  final String label;
  final bool hasIcon;
  final Widget? icon;
  final String? iconAlignment;
  final ButtonStyle? buttonStyle;
  final VoidCallback onPressed;

  const AppFilledButton(
      {super.key,
      required this.label,
      required this.hasIcon,
      this.icon,
      this.iconAlignment,
      this.buttonStyle,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      label: Text(label),
      icon: hasIcon ? icon : const SizedBox.shrink(),
      iconAlignment:
          iconAlignment != null ? IconAlignment.end : IconAlignment.start,
    );
  }
}
