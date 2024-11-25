import 'package:flutter/material.dart';

var navigationDestinations = <Widget>[
  const NavigationDestination(
    selectedIcon: Icon(Icons.home),
    icon: Icon(Icons.home_outlined),
    label: 'Home',
  ),
  const NavigationDestination(
    selectedIcon: Icon(Icons.local_cafe),
    icon: Icon(Icons.local_cafe_outlined),
    label: 'Cafe',
  ),
  const NavigationDestination(
    selectedIcon: Icon(Icons.person_search),
    icon: Icon(Icons.person_search_outlined),
    label: 'Tìm kiếm',
  ),
  const NavigationDestination(
    icon: Icon(Icons.person_outline),
    selectedIcon: Icon(Icons.person),
    label: 'Profile',
  ),
  const NavigationDestination(
    selectedIcon: Badge(child: Icon(Icons.notifications)),
    icon: Badge(child: Icon(Icons.notifications_outlined)),
    label: 'Thông báo',
  ),
];
