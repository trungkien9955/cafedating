import 'package:cafedating/features/search/view/search_intro_screen.dart';
import 'package:cafedating/features/cafe/views/cafes_screen.dart';
import 'package:cafedating/features/home/view/home_screen.dart';
import 'package:cafedating/features/notification/view/notis_screen.dart';
import 'package:cafedating/features/profile/view/profile_screen.dart';
import 'package:flutter/material.dart';

Widget appDestinations({required int index}) {
  List<Widget> destinations = [
    const HomeScreen(),
    const CafesScreen(),
    const SearchIntroScreen(),
    const ProfileScreen(),
    const NotisScreen(),
  ];
  return destinations[index];
}
