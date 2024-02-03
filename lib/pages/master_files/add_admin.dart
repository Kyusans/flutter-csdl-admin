import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/loading_spinner.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
import 'package:flutter_csdl_admin/components/my_textfield.dart';
import 'package:flutter_csdl_admin/pages/master_files/show_alert.dart';
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
        ShowAlert().showAlert("error", "User ID already exists");
      } else if (res.body == "1") {
        ShowAlert().showAlert("success", "Successfully added");
        _firstNameController.clear();
        _lastNameController.clear();
        _usernameController.clear();
        _emailController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
      } else {
        ShowAlert().showAlert("error", "Failed to add");
        print("Res.body" + res.body);
      }
    } catch (e) {
      ShowAlert().showAlert("error", "Network error");
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
                  isEmail: false,
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
                  isEmail: false,
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
                  isEmail: false,
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
                  isEmail: true,
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
                  isEmail: false,
                  isNumber: false,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: MyTextField(
                  labelText: "Confirm Password*",
                  isEmail: false,
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
                  Get.back();
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
                          ShowAlert().showAlert(
                              "Error", "Confirm password does not match");
                        } else {
                          if (_formKey.currentState!.validate()) {
                            addAdmin();
                          }
                        }
                      },
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
