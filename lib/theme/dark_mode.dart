import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade300,
    inversePrimary: Colors.blue[900],
    inverseSurface: Colors.lightGreen[800],
  ),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.grey[200],
        displayColor: Colors.white,
      ),
);
