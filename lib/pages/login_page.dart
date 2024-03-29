import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/loading_spinner.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
import 'package:flutter_csdl_admin/components/my_textfield.dart';
import 'package:flutter_csdl_admin/local_storage.dart';
import 'package:flutter_csdl_admin/components/show_alert.dart';
import 'package:flutter_csdl_admin/session_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LocalStorage _localStorage = LocalStorage();
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _localStorage.init();
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
        //                       para sa dashboard ni hehe
        _localStorage.setValue("selectedIndex", "0");
        _localStorage.setValue("userId", resBody["adm_id"].toString());
        _localStorage.setValue("fullName", resBody["adm_name"].toString());
        _localStorage.setValue("email", resBody["adm_email"].toString());
        _localStorage.setValue("userImage", resBody["adm_image"].toString());
        _localStorage.setValue(
          "employeeId",
          resBody["adm_employee_id"].toString(),
        );
        ShowAlert().showAlert("success", "Welcome ${resBody["adm_name"]}");
        Get.toNamed("/dashboard");
      } else {
        ShowAlert().showAlert("error", "Invalid Id or password");
      }
    } catch (e) {
      ShowAlert().showAlert("error", "Network error");
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
            return Padding(
              padding: const EdgeInsets.only(bottom: 250.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 150.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                  Column(
                    children: [
                      Expanded(
                        child: _buildLoginSection(context),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Container(
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              child: _buildLoginSection(context),
            );
          }
        },
      ),
    );
  }

  Widget _buildLoginSection(context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Card(
          elevation: 5,
          color: const Color.fromARGB(175, 49, 49, 49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
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
              SizedBox(
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      MyTextField(
                        labelText: "Id",
                        obscureText: false,
                        willValidate: true,
                        controller: userIdController,
                        isNumber: false,
                        isEmail: false,
                        icon: null,
                      ),
                      const SizedBox(height: 16),
                      MyTextField(
                        labelText: "Password",
                        obscureText: true,
                        isNumber: false,
                        willValidate: true,
                        controller: passwordController,
                        isEmail: false,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
