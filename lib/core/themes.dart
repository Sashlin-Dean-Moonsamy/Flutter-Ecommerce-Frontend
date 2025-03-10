import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.white,
    inversePrimary: Colors.grey.shade500,
  ),

  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Colors.black),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black, // This sets the text color
    ),
  ),

  iconTheme: IconThemeData(
    color: Colors.white
  ),

  listTileTheme: ListTileThemeData(
    iconColor: Colors.black
  )

);
