import 'package:cafedating/core/common/widgets/app_chip.dart';
import 'package:cafedating/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlaceTypesWidget extends StatelessWidget {
  final List<String> types;
  const PlaceTypesWidget({super.key, required this.types});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
          children: types.map<Widget>((item) {
        if (item == 'cafe') {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AppChip(
              avatar: Icon(Icons.local_bar, color: Colors.white),
              label: Text('Cafe'),
              hasBgColor: true,
              bgColor: AppTheme.redAccent,
            ),
          );
        }
        if (item == 'restaurant') {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AppChip(
              avatar: Icon(Icons.restaurant, color: Colors.white),
              label: Text('Nhà hàng'),
              hasBgColor: true,
              bgColor: AppTheme.orangeAccent,
            ),
          );
        }
        return SizedBox.shrink();
      }).toList()),
    );
  }
}
