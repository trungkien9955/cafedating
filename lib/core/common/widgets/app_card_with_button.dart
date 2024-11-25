import 'package:cafedating/core/common/widgets/app_secondary_text_button.dart';
import 'package:cafedating/core/common/widgets/app_text_button.dart';
import 'package:cafedating/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppCardWithButton extends StatelessWidget {
  final Widget child;
  final String buttonLabel;
  final VoidCallback? onIconPressed;
  final Color? bgColor;
  const AppCardWithButton({
    super.key,
    this.bgColor,
    required this.buttonLabel,
    this.onIconPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    return Badge(
      isLabelVisible: true,
      backgroundColor: Colors.transparent,
      offset: const Offset(-80, 14),
      label: AppTextButton(
        label: 'Thay đổi',
        color: isLightTheme ? AppTheme.primaryColor : AppTheme.darkPrimaryColor,
        onPress: onIconPressed,
      ),
      child: Card.filled(
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 30, 12, 12),
          child: child,
        ),
      ),
    );
  }
}
