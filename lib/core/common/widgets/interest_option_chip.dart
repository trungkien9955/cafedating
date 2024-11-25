import 'package:cafedating/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InterestOptionChip extends StatelessWidget {
  final String id;
  final String name;
  final String type;
  final Color? bgColor;
  final bool hasBgColor;
  final bool selected;
  final VoidCallback onPressed;
  const InterestOptionChip({
    super.key,
    required this.id,
    required this.name,
    required this.type,
    this.bgColor,
    required this.hasBgColor,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ActionChip(
        avatar: type == 'Art'
            ? const Icon(
                Icons.palette,
              )
            : type == 'Music'
                ? const Icon(Icons.music_note)
                : type == 'Outdoor'
                    ? const Icon(Icons.directions_bike)
                    : type == 'pet'
                        ? const Icon(Icons.pets)
                        : type == 'Social'
                            ? const Icon(Icons.diversity_3)
                            : type == 'Travel'
                                ? const Icon(Icons.flight)
                                : type == 'Personal'
                                    ? const Icon(Icons.face_3)
                                    : type == 'Shopping'
                                        ? const Icon(Icons.shopping_cart)
                                        : type == 'Sport'
                                            ? const Icon(Icons.sports_soccer)
                                            : type == 'Tech'
                                                ? const Icon(
                                                    Icons.important_devices)
                                                : type == 'Food'
                                                    ? const Icon(Icons.flatware)
                                                    : type == 'Drink'
                                                        ? const Icon(
                                                            Icons.local_cafe)
                                                        : type == 'Fitness'
                                                            ? const Icon(Icons
                                                                .fitness_center)
                                                            : type == 'Indoor'
                                                                ? const Icon(Icons
                                                                    .other_houses)
                                                                : type == 'Game'
                                                                    ? const Icon(
                                                                        Icons
                                                                            .sports_esports)
                                                                    : const Icon(
                                                                        Icons
                                                                            .work),
        label: Text(name),
        labelStyle: TextStyle(color: selected ? Colors.white : null),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        side: selected
            ? BorderSide.none
            : BorderSide(color: AppTheme.onTertiaryContainerColor),
        backgroundColor: selected
            ? AppTheme.secondaryColor
            : AppTheme.tertiaryContainerColor,
        onPressed: onPressed,
      ),
    );
  }
}
