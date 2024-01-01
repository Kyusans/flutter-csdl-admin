import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade700,
    secondary: Colors.grey.shade500,
    inversePrimary: Colors.grey.shade300,
  ),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.grey[200],
        displayColor: Colors.white,
      ),
);
