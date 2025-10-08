import 'package:flutter/material.dart';

class AppTheme {
  static final Color primaryColor = Colors.blue.shade700; // Ocean Blue

  static final lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: const Color(0xFFF3F4F6),
    fontFamily: 'Inter',
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: Colors.blueAccent,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: const Color(0xFF121212),
    fontFamily: 'Inter',
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: Colors.lightBlueAccent,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1F1F1F),
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
