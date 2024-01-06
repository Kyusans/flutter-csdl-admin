import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/pages/add_scholar.dart';
import 'package:flutter_csdl_admin/pages/dashboard.dart';
// import 'package:flutter_csdl_admin/pages/dashboard.dart';
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
      routes: {
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const Dashboard(),
        '/addScholar': (context) => const AddScholar(),
      },
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      //LoginPage()
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
