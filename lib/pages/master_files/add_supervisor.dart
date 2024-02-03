import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/loading_spinner.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
import 'package:flutter_csdl_admin/components/my_textfield.dart';
import 'package:flutter_csdl_admin/pages/master_files/show_alert.dart';
import 'package:flutter_csdl_admin/session_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddSupervisor extends StatefulWidget {
  const AddSupervisor({Key? key}) : super(key: key);

  @override
  _AddSupervisorState createState() => _AddSupervisorState();
}

class _AddSupervisorState extends State<AddSupervisor> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  int _selectedDepartment = 0;
  Map<int, String> departmentMap = {};
  bool _isLoading = false;
  bool _isSubmitted = false;

  void getDepartment() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Map<String, String> requestBody = {"operation": "getDepartment"};
      var res = await http.post(
        Uri.parse("${SessionStorage.url}admin.php"),
        body: requestBody,
      );

      if (res.statusCode == 200 && res.body.isNotEmpty) {
        List<dynamic> departments = jsonDecode(res.body);
        departmentMap = {
          for (var department in departments)
            department['dept_id']: department['dept_name'],
        };
        print("department map $departmentMap");
      } else {
        ShowAlert().showAlert("error", "Failed to fetch department data");
      }
    } catch (e) {
      print("Failed to fetch department data. Error: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void addSupervisor() async {
    setState(() {
      _isSubmitted = true;
    });
    try {
      Map<String, String> jsonData = {
        "firstName": _firstNameController.text,
        "lastName": _lastNameController.text,
        "employeeId": _employeeIdController.text,
        "password": _passwordController.text,
        "email": _emailController.text,
        "department": _selectedDepartment.toString(),
      };
      print("jsondata: $jsonData");
      Map<String, String> requestBody = {
        "operation": "addSupervisor",
        "json": jsonEncode(jsonData),
      };
      var res = await http.post(
        Uri.parse("${SessionStorage.url}admin.php"),
        body: requestBody,
      );
      if (res.body == "-1") {
        ShowAlert().showAlert("error", "Employee ID already exists");
      } else if (res.body == "1") {
        ShowAlert().showAlert("success", "Successfully added");
        _firstNameController.clear();
        _lastNameController.clear();
        _employeeIdController.clear();
        _passwordController.clear();
        _confirmPasswordController.clear();
        _emailController.clear();
        setState(() {
          _selectedDepartment = 0;
        });
      } else {
        ShowAlert().showAlert("error", "Failed to add supervisor");
        print("Res.body $res");
      }
    } catch (e) {
      ShowAlert().showAlert("error", "Network error");
    } finally {
      setState(() {
        _isSubmitted = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDepartment();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: _isLoading
          ? const LoadingSpinner()
          : Column(
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
                        isEmail: false,
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
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyTextField(
                        labelText: "Employee Id*",
                        obscureText: false,
                        willValidate: true,
                        controller: _employeeIdController,
                        isEmail: false,
                        isNumber: false,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: MyTextField(
                        labelText: "Email*",
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
                  height: 16,
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
                        isEmail: false,
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
                      isEmail: false,
                      isNumber: false,
                    ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<int>(
                  value: _selectedDepartment,
                  items: [
                    const DropdownMenuItem<int>(
                      value: 0,
                      child: Text("Select Department*"),
                    ),
                    ...departmentMap.entries.map((entry) {
                      return DropdownMenuItem<int>(
                        value: entry.key,
                        child: Text(
                          entry.value,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                  onChanged: (int? newValue) {
                    setState(() {
                      _selectedDepartment = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value == 0) {
                      return "This field is required";
                    }
                    return null;
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.white,
                  ),
                  dropdownColor: Theme.of(context).colorScheme.onInverseSurface,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.onInverseSurface,
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onInverseSurface,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    labelText: 'Department *',
                    labelStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 24,
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
                    _isSubmitted
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
                                  addSupervisor();
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
