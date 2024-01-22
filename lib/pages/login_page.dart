import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/loading_spinner.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
import 'package:flutter_csdl_admin/components/my_textfield.dart';
import 'package:flutter_csdl_admin/pages/dashboard.dart';
import 'package:flutter_csdl_admin/session_storage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Map<String, String> jsonData = {
        "userId": userIdController.text,
        "password": passwordController.text,
      };
      Map<String, String> requestBody = {
        "json": jsonEncode(jsonData),
        "operation": "login"
      };

      var res = await http.post(
        Uri.parse("${SessionStorage.url}admin.php"),
        body: requestBody,
      );

      print("res.body: " + res.body);
      var resBody = json.decode(res.body);

      if (res.body != "0") {
        // print("res.body.adm_id: " + resBody["adm_id"].toString());
        SessionStorage.userId = resBody["adm_id"].toString();
        SessionStorage.fullName = resBody["adm_name"].toString();
        SessionStorage.email = resBody["adm_email"].toString();
        SessionStorage.employeeId = resBody["adm_employee_id"].toString();

        // print("SessionStorage.userId: " + SessionStorage.userId);
        // print("SessionStorage.fullName: " + SessionStorage.fullName);
        // print("SessionStorage.email: " + SessionStorage.email);

        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
          ),
        );
      } else {
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Invalid Id or password",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "There was an unexpected error: $e",
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
          duration: const Duration(seconds: 3),
        ),
      );

      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1300) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(200, 100, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "SAMS",
                        style: TextStyle(
                          fontSize: 150,
                        ),
                      ),
                      Text(
                        "School Attendance",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        "Monitoring System",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(650, 30, 50, 250),
                    child: _buildLoginSection(context),
                  ),
                ),
              ],
            );
          } else {
            return _buildLoginSection(context);
          }
        },
      ),
    );
  }

  Widget _buildLoginSection(context) {
    return Center(
      child: SingleChildScrollView(
        child: Card(
          elevation: 5,
          color: const Color.fromARGB(175, 49, 49, 49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 75),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Sign in your account",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      MyTextField(
                        labelText: "Id",
                        obscureText: false,
                        willValidate: true,
                        controller: userIdController,
                        isNumber: false,
                        icon: null,
                      ),
                      const SizedBox(height: 16),
                      MyTextField(
                        labelText: "Password",
                        obscureText: true,
                        isNumber: false,
                        willValidate: true,
                        controller: passwordController,
                        icon: null,
                      ),
                      const SizedBox(height: 16),
                      _isLoading
                          ? const LoadingSpinner()
                          : MyButton(
                              buttonText: "Login",
                              buttonSize: 16,
                              onPressed: () {
                                _login();
                              },
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
