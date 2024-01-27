import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/loading_spinner.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
import 'package:flutter_csdl_admin/components/my_textfield.dart';
import 'package:flutter_csdl_admin/session_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddAdmin extends StatefulWidget {
  const AddAdmin({Key? key}) : super(key: key);

  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void addAdmin() async {
    setState(() {
      _isLoading = false;
    });
    try {
      Map<String, String> jsonData = {
        "firstName": _firstNameController.text,
        "lastName": _lastNameController.text,
        "userId": _usernameController.text,
        "username": _usernameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
      };
      Map<String, String> requestBody = {
        "json": jsonEncode(jsonData),
        "operation": "addAdmin",
      };
      var res = await http.post(
        Uri.parse("${SessionStorage.url}admin.php"),
        body: requestBody,
      );
      if (res.body == "-1") {
        Get.snackbar(
          "Error",
          "User ID already exists",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      } else if (res.body == "1") {
        Get.snackbar(
          "Success",
          "Successfully added",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      } else {
        Get.snackbar(
          "Error",
          "Something went wrong",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
        print("Res.body" + res.body);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: MyTextField(
                  labelText: "First Name*",
                  obscureText: false,
                  willValidate: true,
                  controller: _firstNameController,
                  isNumber: false,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: MyTextField(
                  labelText: "Last Name*",
                  obscureText: false,
                  willValidate: true,
                  controller: _lastNameController,
                  isNumber: false,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            children: [
              Expanded(
                child: MyTextField(
                  labelText: "User ID*",
                  obscureText: false,
                  willValidate: true,
                  controller: _usernameController,
                  isNumber: false,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: MyTextField(
                  labelText: "Email Address*",
                  obscureText: false,
                  willValidate: true,
                  controller: _emailController,
                  isNumber: false,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            children: [
              Expanded(
                child: MyTextField(
                  labelText: "Password*",
                  obscureText: true,
                  willValidate: true,
                  controller: _passwordController,
                  isNumber: false,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: MyTextField(
                  labelText: "Confirm Password*",
                  obscureText: true,
                  willValidate: true,
                  controller: _confirmPasswordController,
                  isNumber: false,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyButton(
                buttonText: "Back",
                buttonSize: 8,
                color: Colors.red,
                onPressed: () {
                  Navigator.pop(context);
                  Get.toNamed("/dashboard");
                },
              ),
              const SizedBox(
                width: 16,
              ),
              _isLoading
                  ? const LoadingSpinner()
                  : MyButton(
                      buttonText: "Submit",
                      buttonSize: 8,
                      color: Theme.of(context).colorScheme.tertiary,
                      onPressed: () {
                        if (_confirmPasswordController.text !=
                            _passwordController.text) {
                          Get.snackbar(
                            "Error",
                            "Confirm password does not match",
                            colorText: Colors.white,
                            backgroundColor: Colors.red,
                          );
                        } else {
                          if (_formKey.currentState!.validate()) {
                            addAdmin();
                          }
                        }
                      },
                    ),
            ],
          )
        ],
      ),
    );
  }
}
