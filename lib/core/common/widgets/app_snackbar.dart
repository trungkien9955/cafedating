import 'package:cafedating/core/common/widgets/app_width_spacer.dart';
import 'package:cafedating/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppSnackbar {
  static showSuccessMsg(BuildContext context, String message) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
      showCloseIcon: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0, // Inner padding for SnackBar content.
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green.shade500,
    ));
  }

  static showWarningMsg(BuildContext context, String message) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: isLightTheme
                ? AppTheme.onTertiaryContainerColor
                : AppTheme.darkOnTertiaryContainerColor,
          ),
          const AppWidthSpacer(width: 20),
          Text(
            message,
            style: TextStyle(
                color: isLightTheme
                    ? AppTheme.onTertiaryContainerColor
                    : AppTheme.darkOnTertiaryContainerColor),
          )
        ],
      ),
      showCloseIcon: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0, // Inner padding for SnackBar content.
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: isLightTheme
          ? AppTheme.tertiaryContainerColor
          : AppTheme.darkTertiaryContainerColor,
    ));
  }

  static showInfoMsg(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.error,
            color: Colors.white,
          ),
          Flexible(
              child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ))
        ],
      ),
      showCloseIcon: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0, // Inner padding for SnackBar content.
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.blue.shade500,
    ));
  }
}
