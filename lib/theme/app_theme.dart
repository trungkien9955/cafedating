import 'package:cafedating/core/common/colors/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const blackColor = Color.fromRGBO(1, 1, 1, 1); // primary color
  static const surfaceDark = Color.fromRGBO(20, 17, 21, 1); // primary color
  static const greyColor = Color.fromRGBO(26, 39, 45, 1); // secondary color
  static const drawerColor = Color.fromRGBO(18, 18, 18, 1);
  static const whiteColor = Colors.white;
  static const primaryColor = Colors.pink;
  static const onPrimaryColor = Colors.white;
  static const primaryContainerColor = Color(0xFFFF87DD);
  static const onPrimaryContainerColor = Color(0xFF5B0000);
  static const secondaryColor = Color(0xFFF56FA1);
  static const secondaryContainerColor = Color(0xFFFFD3FF);
  static const onSecondaryContainerColor = Color(0xFF9D1547);
  static const tertiaryColor = Color(0xFF6495ED);
  static const tertiaryContainerColor = Color(0xFFC8F9FF);
  static const onTertiaryContainerColor = Color(0xFF0A3B9A);
  static const backgroundColor = Color(0xFFF5F5FA);
  static const onBackgroundColor = Color(0xFF2D2D32);
  static const surfaceColor = Color(0xFFDCE2FC);
  static const onSurfaceColor = Color(0xFF232328);
  static const lowSurfaceColor = Color(0xFFF0F6FF);
  static const onLowSurfaceColor = Color(0xFF8C92AC);
  static const highSurfaceColor = Color(0xFFC8CEE8);
  static const onHighSurfaceColor = Color(0xFF505670);
  static const outlineColor = Color(0xFFa0a6c0);
  static const darkPrimaryColor = Color(0xFFFF699F);
  static const onDarkPrimaryColor = Color(0xFF790000);
  static const darkPrimaryContainerColor = Color(0xFFFF87BD);
  static const darkOnPrimaryContainerColor = Color(0xFF5B0000);
  static const darkSecondaryColor = Color(0xFFB50027);
  static const darkOnSecondaryColor = Color(0xFFB93365);
  static const darkSecondaryContainerColor = Color(0xFFF56FA1);
  static const darkOnSecondaryContainerColor = Color(0xFFFFE7FF);
  static const darkTertiaryColor = Color(0xFFB4E5FF);
  static const darkOnTertiaryColor = Color(0xFF2859b1);
  static const darkTertiaryContainerColor = Color(0xFF6495ED);
  static const darkOnTertiaryContainerColor = Color(0xFFC8F9FF);
  static const darkSurfaceColor = Color(0xFF232328);
  static const darkSurfaceContainerColor = Color(0xFF414146);
  static const darkHighSurfaceColor = Color(0xFF55555A);
  static const darkOnsurfaceColor = Color(0xFFF5F5FA);
  static const darkOnsurfaceColorVariant = Color(0xFFE1E1E6);

  // static var primaryColor = Colors.purpleAccent[200];
  static var primaryColorDark = Colors.purpleAccent[400];
  static var primaryColorLight = Colors.purpleAccent[100];
  static var yellowAccent = Colors.yellowAccent[100];
  static var orangeAccent = Colors.orangeAccent[100];
  static var pinkAccent = Colors.pinkAccent[100];
  static var blueAccent = Colors.blueAccent[100];
  static var greenAccent = Colors.greenAccent[400];
  static var redAccent = Colors.redAccent[200];
  // static var blueColor = Colors.blue.shade300;

  // Themes
  //dark
  static var darkModeAppTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: darkSurfaceColor,
      cardColor: const Color.fromRGBO(26, 39, 45, 1),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurfaceColor,
        iconTheme: IconThemeData(
          color: backgroundColor,
        ),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: darkSurfaceColor,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: darkOnsurfaceColor),
        bodyMedium: TextStyle(color: darkOnsurfaceColor),
        bodySmall: TextStyle(color: darkOnsurfaceColor),
      ),
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primaryColorLight: primaryColorLight,
      dialogBackgroundColor:
          darkSurfaceColor, // will be used as alternative background color
      inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: primaryContainerColor, width: .5),
              borderRadius: BorderRadius.circular(16)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade600),
              borderRadius: BorderRadius.circular(16)),
          hintStyle:
              const TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
      dropdownMenuTheme:
          DropdownMenuThemeData(textStyle: TextStyle(fontSize: 14)),
      chipTheme: const ChipThemeData(
        backgroundColor: darkTertiaryContainerColor,
        color: WidgetStatePropertyAll(darkTertiaryContainerColor),
        labelStyle: TextStyle(color: darkOnTertiaryContainerColor),
        iconTheme: IconThemeData(color: darkOnTertiaryContainerColor),
        // side: BorderSide(color: darkOnTertiaryContainerColor)
      ),
      searchBarTheme: SearchBarThemeData(),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: darkPrimaryContainerColor),
      filledButtonTheme: const FilledButtonThemeData(
          style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(darkPrimaryColor),
        textStyle: WidgetStatePropertyAll(TextStyle(color: onDarkPrimaryColor)),
        padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
        minimumSize: WidgetStatePropertyAll(Size(60, 48)),
        iconColor: WidgetStatePropertyAll(onDarkPrimaryColor),
      )),
      cardTheme: CardTheme(color: darkSurfaceContainerColor),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(color: onPrimaryColor),
        unselectedIconTheme: IconThemeData(color: darkOnsurfaceColorVariant),
      ));
//light
  static var lightModeAppTheme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: backgroundColor,
      cardColor: greyColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: primaryColor,
        ),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: backgroundColor,
      ),
      primaryColor: primaryColor,
      dialogBackgroundColor: backgroundColor,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: primaryContainerColor),
      inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: primaryContainerColor, width: .5),
              borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12)),
          hintStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
          fillColor: backgroundColor,
          iconColor: onBackgroundColor),
      buttonTheme: ButtonThemeData(
          minWidth: 60,
          height: 48,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          buttonColor: primaryContainerColor),
      filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(primaryColor),
        textStyle: WidgetStatePropertyAll(TextStyle(color: onPrimaryColor)),
        padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
        minimumSize: WidgetStatePropertyAll(Size(60, 48)),
        iconColor: WidgetStatePropertyAll(onPrimaryColor),
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
              minimumSize: WidgetStatePropertyAll(Size(60, 48)),
              side: WidgetStatePropertyAll(BorderSide(color: primaryColor)))),
      iconTheme: IconThemeData(color: AppColors.primary300),
      snackBarTheme: SnackBarThemeData(backgroundColor: AppColors.primary),
      chipTheme: const ChipThemeData(
          backgroundColor: tertiaryContainerColor,
          labelStyle: TextStyle(color: onTertiaryContainerColor),
          iconTheme: IconThemeData(color: onTertiaryContainerColor),
          side: BorderSide(color: onTertiaryContainerColor)),
      searchBarTheme: SearchBarThemeData(
          backgroundColor: WidgetStatePropertyAll(backgroundColor)),
      cardTheme: CardTheme(color: surfaceColor),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(color: onPrimaryColor),
        unselectedIconTheme: IconThemeData(color: onBackgroundColor),
      ));
}
