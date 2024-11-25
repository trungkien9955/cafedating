import 'package:flutter/material.dart';

class AppTip extends StatelessWidget {
  final String type;
  final String text;
  const AppTip({super.key, required this.type, required this.text});

  @override
  Widget build(BuildContext context) {
    late Widget icon;
    if (type == 'info') {
      icon = Icon(Icons.info_outline);
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        SizedBox(
          width: 8,
        ),
        Flexible(
            child: Text(
          text,
          style: const TextStyle(fontSize: 12),
        ))
      ],
    );
  }
}
