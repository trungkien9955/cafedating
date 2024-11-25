import 'package:cafedating/features/application/widgets/app_destinations.dart';
import 'package:cafedating/features/application/widgets/navigation_destinations.dart';
import 'package:cafedating/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  int currentDestinationIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: appDestinations(index: currentDestinationIndex),
      bottomNavigationBar: NavigationBar(
        destinations: navigationDestinations,

        onDestinationSelected: (int index) {
          setState(() {
            currentDestinationIndex = index;
          });
        },
        selectedIndex: currentDestinationIndex,

        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        // height: 48,
      ),
    );
  }
}
