import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.grey[200],
        displayColor: Colors.white,
      ),
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade400,
    inversePrimary: Colors.grey.shade800,
    inverseSurface: Colors.white,
    // para sa lahi2 nga color
    onPrimary: Colors.grey.shade900,
    onSecondary: Colors.grey.shade800,
    onTertiary: Colors.white,
    tertiary: Colors.blue.shade900,
    onPrimaryContainer: const Color.fromARGB(255, 16, 147, 21),
  ),
);
