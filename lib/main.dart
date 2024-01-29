import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/local_storage.dart';
import 'package:flutter_csdl_admin/pages/dashboard.dart';
import 'package:flutter_csdl_admin/pages/login_page.dart';
import 'package:flutter_csdl_admin/theme/dark_mode.dart';
import 'package:flutter_csdl_admin/theme/light_mode.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorage localStorage = LocalStorage();
  await localStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const Dashboard(),
      },
      home: const LoginPage(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
