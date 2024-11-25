import 'package:cafedating/core/common/widgets/app_chip.dart';
import 'package:cafedating/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CafeTypeIcons extends StatelessWidget {
  final List<String> types;
  const CafeTypeIcons({super.key, required this.types});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
          children: types.map<Widget>((item) {
        if (item == 'cafe') {
          return const Icon(
            Icons.local_bar,
            size: 20,
          );
        }
        if (item == 'store') {
          return const Icon(Icons.local_mall, size: 20);
        }
        if (item == 'food') {
          return const Icon(Icons.local_dining, size: 20);
        }
        if (item == 'point_of_interest') {
          return const Icon(Icons.attractions, size: 20);
        }
        if (item == 'establishment') {
          return const Icon(Icons.home_work, size: 20);
        }

        return SizedBox.shrink();
      }).toList()),
    );
  }
}
