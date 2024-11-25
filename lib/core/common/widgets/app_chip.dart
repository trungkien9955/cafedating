import 'package:cafedating/core/common/colors/app_colors.dart';
import 'package:flutter/material.dart';

class AppChip extends StatelessWidget {
  final Widget avatar;
  final Widget label;
  final bool hasBgColor;
  final Color? bgColor;
  const AppChip(
      {super.key,
      required this.avatar,
      required this.label,
      required this.hasBgColor,
      this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: avatar,
      label: label,
      // labelStyle: TextStyle(color: hasBgColor ? Colors.white : null),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      side: BorderSide.none,
      // backgroundColor: hasBgColor ? bgColor : null,
    );
  }
}
