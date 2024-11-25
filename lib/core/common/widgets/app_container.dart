import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  final Color? color;
  final double? width;
  final double? height;
  final Widget child;
  const AppContainer(
      {super.key, this.color, required this.child, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      decoration: BoxDecoration(
          color: color ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(12)),
      child: child,
    );
  }
}
