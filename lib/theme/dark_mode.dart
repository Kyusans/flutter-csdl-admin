import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade500,
    inversePrimary: Colors.grey.shade800,
    inverseSurface: Colors.blue.shade900,
    // para sa lahi2 nga color
    onPrimary: Colors.grey.shade900,
    onSecondary: Colors.grey.shade600,
    onTertiary: Colors.grey.shade800,
    onBackground: Colors.blue.shade900,
  ),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.grey[200],
        displayColor: Colors.white,
      ),
);
