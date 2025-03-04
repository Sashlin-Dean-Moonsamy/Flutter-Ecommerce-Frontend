import 'package:flutter/material.dart';

final ThemeData LuxTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF1C1C1C), // Deep Black
  scaffoldBackgroundColor: Color(0xFFF4F1E1), // Light Ivory

  appBarTheme: AppBarTheme(
    color: Color(0xFF1C1C1C),
    iconTheme: IconThemeData(color: Colors.white),
  ),

  drawerTheme: DrawerThemeData(
    backgroundColor: Color(0xFF1C1C1C), // Dark background
  ),

  iconTheme: IconThemeData(
    color: Colors.white, // Global white icons
  ),

  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
  ),
);
