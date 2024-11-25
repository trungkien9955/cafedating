import 'package:cafedating/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InterestChip extends StatelessWidget {
  final String name;
  final String type;
  const InterestChip({
    super.key,
    required this.name,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Chip(
          avatar: type == 'Art'
              ? const Icon(Icons.palette)
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
                                                      ? const Icon(
                                                          Icons.flatware)
                                                      : type == 'Drink'
                                                          ? const Icon(
                                                              Icons.local_cafe)
                                                          : type == 'Fitness'
                                                              ? const Icon(Icons
                                                                  .fitness_center)
                                                              : type == 'Indoor'
                                                                  ? const Icon(Icons
                                                                      .other_houses)
                                                                  : type ==
                                                                          'Game'
                                                                      ? const Icon(
                                                                          Icons
                                                                              .sports_esports)
                                                                      : const Icon(
                                                                          Icons
                                                                              .work),
          label: Text(name),
          labelStyle: TextStyle(
              color: isLightTheme
                  ? AppTheme.onTertiaryContainerColor
                  : AppTheme.darkOnTertiaryContainerColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          // side: BorderSide(color: AppTheme.primaryColor!),
          backgroundColor: isLightTheme
              ? AppTheme.tertiaryContainerColor
              : AppTheme.darkTertiaryContainerColor),
    );
  }
}
