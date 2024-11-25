import 'package:cafedating/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppCardWithBadge extends StatelessWidget {
  final Widget child;
  final IconData badgeIcon;
  final VoidCallback? onIconPressed;
  final Color? bgColor;
  final bool hasBgColor;
  const AppCardWithBadge(
      {super.key,
      required this.child,
      this.bgColor,
      required this.hasBgColor,
      required this.badgeIcon,
      this.onIconPressed});

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Badge(
      isLabelVisible: true,
      backgroundColor: Colors.transparent,
      offset: const Offset(-24, 14),
      label: GestureDetector(
        onTap: onIconPressed,
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              // border: Border.all(
              //   width: 2,
              // ),
              borderRadius: BorderRadius.circular(90.0),
              color: isDarkTheme
                  ? AppTheme.darkHighSurfaceColor
                  : AppTheme.tertiaryContainerColor),
          child: Icon(
            badgeIcon,
            size: 16,
            color: isDarkTheme
                ? AppTheme.darkOnsurfaceColorVariant
                : AppTheme.onTertiaryContainerColor,
          ),
        ),
      ),
      child: Card.filled(
        color: hasBgColor ? bgColor : null,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 24, 12, 12),
          child: child,
        ),
      ),
    );
  }
}
