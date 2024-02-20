import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade300,
    inversePrimary: const Color.fromARGB(255, 67, 224, 77),
    inverseSurface: Colors.blue[900],
    // para sa lahi2 nga color
    onPrimary: Colors.blue.shade900,
    onSecondary: Colors.white,
    // pwede ni para sa text
    onTertiary: Colors.black,
    tertiary: const Color.fromARGB(255, 16, 147, 21),
    onPrimaryContainer: Colors.blue[900],
    onInverseSurface: const Color.fromARGB(255, 8, 54, 100),
  ),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.grey[800],
        displayColor: Colors.white,
      ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.white,
  ),
);
