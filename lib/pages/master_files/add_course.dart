import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/loading_spinner.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
import 'package:flutter_csdl_admin/components/my_textfield.dart';
import 'package:flutter_csdl_admin/pages/master_files/show_alert.dart';
import 'package:flutter_csdl_admin/session_storage.dart';
import 'package:http/http.dart' as http;

class AddCourse extends StatefulWidget {
  const AddCourse({Key? key}) : super(key: key);

  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _selectedDepartment = 0;
  Map<int, String> departmentMap = {};
  bool _isLoading = true;
  bool _isSubmitted = false;

  void getDepartment() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Map<String, String> requestBody = {
        "operation": "getDepartment"
      };
      var res = await http.post(
        Uri.parse("${SessionStorage.url}admin.php"),
        body: requestBody,
      );

      if (res.statusCode == 200 && res.body.isNotEmpty) {
        List<dynamic> departments = jsonDecode(res.body);
        departmentMap = {
          for (var department in departments) department['dept_id']: department['dept_name'],
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

  void addCourse() async {
    setState(() {
      _isSubmitted = true;
    });

    try {
      Map<String, String> jsonData = {
        "course": _nameController.text,
        "department": _selectedDepartment.toString(),
      };
      Map<String, String> requestBody = {
        "json": jsonEncode(jsonData),
        "operation": "addCourse"
      };
      var res = await http.post(
        Uri.parse("${SessionStorage.url}admin.php"),
        body: requestBody,
      );
      if (res.body == "-1") {
        ShowAlert().showAlert("error", "Course already exists");
      } else if (res.body == "1") {
        ShowAlert().showAlert("success", "Course added successfully");
        _nameController.clear();
        setState(() {
          _selectedDepartment = 0;
        });
      } else {
        ShowAlert().showAlert("error", "Failed to add course");
        print("res.body" + res.body);
      }
    } catch (e) {
      print("Failed to add course. Error: $e");
      ShowAlert().showAlert("error", "Network error");
    } finally {
      setState(() {
        _isSubmitted = false;
      });
    }
  }

  @override
  void initState() {
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
                  height: 20,
                ),
                MyTextField(
                  labelText: "Course Name*",
                  obscureText: false,
                  willValidate: true,
                  controller: _nameController,
                  isNumber: false,
                  isEmail: false,
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // MyButton(
                    //   buttonText: "Back",
                    //   buttonSize: 8,
                    //   color: Colors.red,
                    //   onPressed: () {
                    //     Get.back();
                    //   },
                    // ),
                    // const SizedBox(
                    //   width: 16,
                    // ),
                    _isSubmitted
                        ? const LoadingSpinner()
                        : MyButton(
                            buttonText: "Submit",
                            buttonSize: 8,
                            color: Theme.of(context).colorScheme.tertiary,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                addCourse();
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
