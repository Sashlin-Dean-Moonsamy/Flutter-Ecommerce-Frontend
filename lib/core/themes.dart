import 'package:flutter/material.dart';

final ThemeData LuxTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF1C1C1C), // Deep Black
  scaffoldBackgroundColor: Color(0xFFD6CFC7),

  appBarTheme: AppBarTheme(
    color: Color(0xFF007C77),
    iconTheme: IconThemeData(color: Colors.black),
  ),

  drawerTheme: DrawerThemeData(
    backgroundColor: Color(0xFF007C77), // Dark background
  ),

  iconTheme: IconThemeData(
    color: Colors.black, // Global white icons
  ),

  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    bodySmall: TextStyle(color: Colors.black),
  ),
);
