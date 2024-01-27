// import 'dart:convert';
import 'package:flutter_csdl_admin/components/loading_spinner.dart';
import 'package:flutter_csdl_admin/local_storage.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
import 'package:flutter_csdl_admin/components/my_textfield.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _confirmEmailController = TextEditingController();
  bool _isLoading = false;
  late LocalStorage _localStorage;

  @override
  void initState() {
    super.initState();
    _initializeLocalStorage();
  }

  Future<void> _initializeLocalStorage() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _localStorage = LocalStorage();
      await _localStorage.init();

      setState(() {
        _fullNameController.text = _localStorage.getValue("fullName");
        _userIdController.text = _localStorage.getValue("employeeId");
        _emailController.text = _localStorage.getValue("email");
      });
    } catch (e) {
      print("Initialization Error: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const LoadingSpinner()
        : Column(
            children: [
              Card(
                elevation: 4,
                color: Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Image",
                        style: TextStyle(fontSize: 30),
                      ),
                      // CachedNetworkImage(
                      //   imageUrl: SessionStorage.getUserImage(),
                      //   placeholder: (context, url) => const LoadingSpinner(),
                      // ),
                      MyButton(
                        buttonText: "Update Photo",
                        buttonSize: 8,
                        color: Theme.of(context).colorScheme.tertiary,
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Card(
                elevation: 4,
                color: Theme.of(context).colorScheme.onPrimary,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 64.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: MyTextField(
                                labelText: "Full Name*",
                                obscureText: false,
                                willValidate: true,
                                controller: _fullNameController,
                                isNumber: false,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: MyTextField(
                                labelText: "User ID*",
                                obscureText: false,
                                willValidate: true,
                                controller: _userIdController,
                                isNumber: false,
                              ),
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
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: MyTextField(
                                labelText: "New Password*",
                                obscureText: true,
                                willValidate: true,
                                controller: _passwordController,
                                isNumber: false,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: MyTextField(
                                labelText: "Confirm Password*",
                                obscureText: true,
                                willValidate: true,
                                controller: _confirmPasswordController,
                                isNumber: false,
                              ),
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
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: MyTextField(
                                labelText: "Email Address*",
                                obscureText: false,
                                willValidate: true,
                                controller: _emailController,
                                isNumber: false,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: MyTextField(
                                labelText: "Confirm Email Address*",
                                obscureText: false,
                                willValidate: true,
                                controller: _confirmEmailController,
                                isNumber: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            child: MyButton(
                              buttonText: "Update Info",
                              buttonSize: 12,
                              color: Theme.of(context).colorScheme.tertiary,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
  }
}
