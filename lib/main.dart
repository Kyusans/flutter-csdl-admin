import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/pages/dashboard.dart';
import 'package:flutter_csdl_admin/pages/login_page.dart';
import 'package:flutter_csdl_admin/theme/dark_mode.dart';
import 'package:flutter_csdl_admin/theme/light_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
      //LoginPage()
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
