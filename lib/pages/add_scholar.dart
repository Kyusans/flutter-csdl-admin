import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/loading_spinner.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
import 'package:flutter_csdl_admin/components/my_textfield.dart';
import 'package:flutter_csdl_admin/components/show_alert.dart';
import 'package:flutter_csdl_admin/session_storage.dart';
import 'package:http/http.dart' as http;

class AddScholar extends StatefulWidget {
  const AddScholar({Key? key}) : super(key: key);

  @override
  _AddScholarState createState() => _AddScholarState();
}

class _AddScholarState extends State<AddScholar> {
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _schoolIdController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> yearLevel = [
    "1st Year",
    "2nd Year",
    "3rd Year",
    "4th Year",
  ];

  Map<int, String> courseMap = {};
  Map<int, String> scholarTypeMap = {};
  String _selectedYearLevel = "";
  int _selectedCourseId = 0;
  int _selectedScholarshipType = 0;
  bool _isLoading = false;
  String responseMessage = "Unsuccessful";
  bool isSuccess = false;

  void addScholar() async {
    setState(() {
      _isLoading = false;
    });
    try {
      Map<String, String> jsonData = {
        "schoolId": _schoolIdController.text,
        "firstName": _firstNameController.text,
        "lastName": _lastNameController.text,
        "yearLevel": _selectedYearLevel,
        "contact": _contactController.text,
        "courseId": _selectedCourseId.toString(),
        "scholarShipId": _selectedScholarshipType.toString(),
      };
      Map<String, String> requestBody = {
        "json": jsonEncode(jsonData),
        "operation": "addScholar",
      };
      var res = await http.post(
        Uri.parse("${SessionStorage.url}admin.php"),
        body: requestBody,
      );
      print("res ni addScholar: " + res.body);
      if (res.body == "1") {
        setState(() {
          ShowAlert().showAlert("success", "Successfully added");
          isSuccess = true;
        });
      } else {
        setState(() {
          ShowAlert().showAlert("danger", "Failed to add");
          isSuccess = false;
        });
      }
    } catch (e) {
      ShowAlert().showAlert("danger", "Network error");
      print("There was an unexpected error: $e");
    } finally {
      setState(() {
        if (isSuccess) {
          _selectedYearLevel = "";
          _selectedCourseId = 0;
          _selectedScholarshipType = 0;
          _contactController.text = "";
          _firstNameController.text = "";
          _lastNameController.text = "";
          _schoolIdController.text = "";
        }
        _isLoading = false;
      });
    }
  }

  void getCourse() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Map<String, String> requestBody = {"operation": "getCourse"};
      var res = await http.post(
        Uri.parse("${SessionStorage.url}admin.php"),
        body: requestBody,
      );

      if (res.statusCode == 200) {
        List<dynamic> courses = jsonDecode(res.body);
        courseMap = {
          for (var course in courses) course['crs_id']: course['crs_name']
        };
        print("course map $courseMap");
      }
    } catch (e) {
      print("Failed to fetch course data. Status code: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void getScholarshipType() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Map<String, String> requestBody = {"operation": "getScholarshipType"};
      var res = await http.post(
        Uri.parse("${SessionStorage.url}admin.php"),
        body: requestBody,
      );

      if (res.statusCode == 200) {
        List<dynamic> scholarType = jsonDecode(res.body);
        scholarTypeMap = {
          for (var type in scholarType) type['type_id']: type['type_name']
        };
        print("course map $courseMap");
      }
    } catch (e) {
      print("Failed to fetch scholarType data. Status code: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      getScholarshipType();
      getCourse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Card(
        elevation: 4,
        color: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 100.0),
          child: _isLoading
              ? const LoadingSpinner()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 16.0,
                            ),
                            child: MyTextField(
                              labelText: "First name *",
                              obscureText: false,
                              isNumber: false,
                              willValidate: true,
                              isEmail: false,
                              controller: _firstNameController,
                            ),
                          ),
                        ),
                        Expanded(
                          child: MyTextField(
                            labelText: "Last name *",
                            obscureText: false,
                            isNumber: false,
                            willValidate: true,
                            isEmail: false,
                            controller: _lastNameController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: MyTextField(
                              labelText: "School id *",
                              willValidate: true,
                              isNumber: false,
                              obscureText: false,
                              isEmail: false,
                              controller: _schoolIdController,
                            ),
                          ),
                        ),
                        Expanded(
                          child: MyTextField(
                            labelText: "Contact number *",
                            willValidate: true,
                            isNumber: true,
                            obscureText: false,
                            isEmail: false,
                            controller: _contactController,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Column(
                      children: [
                        // Year level dropdown

                        DropdownButtonFormField<String>(
                          value: _selectedYearLevel,
                          items: [
                            const DropdownMenuItem<String>(
                              value: "",
                              child: Text("Select Year level"),
                            ),
                            ...yearLevel.map((entry) {
                              return DropdownMenuItem<String>(
                                value: entry,
                                child: Text(entry),
                              );
                            }),
                          ],
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedYearLevel = newValue!;
                            });
                          },
                          validator: (value) {
                            if (value == null || value == "") {
                              return "This field is required";
                            }
                            return null;
                          },
                          icon: const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.white,
                          ),
                          dropdownColor:
                              Theme.of(context).colorScheme.onInverseSurface,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor:
                                Theme.of(context).colorScheme.onInverseSurface,
                            border: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onInverseSurface,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            labelText: 'Year Level *',
                            labelStyle: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),

                        const SizedBox(height: 24),

                        // course dropdown

                        DropdownButtonFormField<int>(
                          value: _selectedCourseId,
                          items: [
                            const DropdownMenuItem<int>(
                              value: 0,
                              child: Text("Select Course"),
                            ),
                            ...courseMap.entries.map((entry) {
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
                              _selectedCourseId = newValue!;
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
                          dropdownColor:
                              Theme.of(context).colorScheme.onInverseSurface,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor:
                                Theme.of(context).colorScheme.onInverseSurface,
                            border: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onInverseSurface,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            labelText: 'Course *',
                            labelStyle: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),

                        const SizedBox(height: 32),

                        // Scholarship  type dropdown

                        DropdownButtonFormField<int>(
                          value: _selectedScholarshipType,
                          items: [
                            const DropdownMenuItem<int>(
                              value: 0,
                              child: Text("Scholarship Type"),
                            ),
                            ...scholarTypeMap.entries.map((entry) {
                              return DropdownMenuItem<int>(
                                value: entry.key,
                                child: Text(entry.value),
                              );
                            }).toList(),
                          ],
                          onChanged: (int? newValue) {
                            setState(() {
                              _selectedScholarshipType = newValue!;
                            });
                          },
                          validator: (value) {
                            if (value == null || value == 0) {
                              return "This field is required";
                            }
                            return null;
                          },
                          dropdownColor:
                              Theme.of(context).colorScheme.onInverseSurface,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor:
                                Theme.of(context).colorScheme.onInverseSurface,
                            border: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onInverseSurface,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            labelText: 'Scholarship Type *',
                            labelStyle: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        MyButton(
                          buttonText: "Add Scholar",
                          buttonSize: 16,
                          color: Theme.of(context).colorScheme.tertiary,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              addScholar();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
