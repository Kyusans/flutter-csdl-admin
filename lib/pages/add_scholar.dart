import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/loading_spinner.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
import 'package:flutter_csdl_admin/components/my_textfield.dart';
import 'package:flutter_csdl_admin/session_storage.dart';
import 'package:http/http.dart' as http;

class AddScholar extends StatefulWidget {
  const AddScholar({Key? key}) : super(key: key);

  @override
  _AddScholarState createState() => _AddScholarState();
}

class _AddScholarState extends State<AddScholar> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String _selectedYearLevel = "";
  int _selectedCourse = 0;
  final List<String> yearLevel = [
    "Select year level",
    "1st Year",
    "2nd Year",
    "3rd Year",
    "4th Year",
  ];

  Map<int, String> courseMap = {};
  int _selectedCourseId = 0;
  bool _isLoading = false;

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

  void setYearLevel(String? selectedValue) {
    setState(() {
      _selectedYearLevel = selectedValue!;
      print("Selected year level: " + _selectedYearLevel);
    });
  }

  void setCourse(int? selectedValue) {
    setState(() {
      _selectedCourse = selectedValue!;
      print("Selected course Id: ${_selectedCourse}");
    });
  }

  @override
  void initState() {
    super.initState();
    getCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(64, 50, 64, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Add Scholar',
            style: TextStyle(
              color: Theme.of(context).colorScheme.inverseSurface,
              fontSize: 36,
            ),
          ),
          Text(
            'Enroll the scholar by completing the registration form.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.inverseSurface,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
            elevation: 4,
            color: Theme.of(context).colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Fill the Form',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                    ),
                  ),
                  const Text(
                    'Fill out the form by the given below.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          child: MyTextField(
                            labelText: "First name",
                            obscureText: false,
                            willValidate: true,
                            controller: _firstNameController,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          child: MyTextField(
                            labelText: "Last name",
                            obscureText: false,
                            willValidate: true,
                            controller: _lastNameController,
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          child: MyTextField(
                            labelText: "School id",
                            willValidate: true,
                            obscureText: false,
                            controller: _firstNameController,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          child: MyTextField(
                            labelText: "Contact number",
                            willValidate: true,
                            obscureText: false,
                            controller: _lastNameController,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  _isLoading
                      ? const LoadingSpinner()
                      : Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: DropdownButtonFormField<String>(
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
                                    if (value == null || value == 0) {
                                      return "This field is required";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    labelText: 'Course',
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: DropdownButtonFormField<int>(
                                  value: _selectedCourseId,
                                  items: [
                                    const DropdownMenuItem<int>(
                                      value: 0,
                                      child: Text("Select Course"),
                                    ),
                                    ...courseMap.entries.map((entry) {
                                      return DropdownMenuItem<int>(
                                        value: entry.key,
                                        child: Text(entry.value),
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
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    labelText: 'Course',
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: MyButton(
                          buttonText: "Add Scholar",
                          buttonSize: 16,
                          color: Theme.of(context).colorScheme.tertiary,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
