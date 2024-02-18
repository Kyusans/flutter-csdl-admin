import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_csdl_admin/components/loading_spinner.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
import 'package:flutter_csdl_admin/components/my_textfield.dart';
import 'package:flutter_csdl_admin/components/show_alert.dart';
import 'package:flutter_csdl_admin/session_storage.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toggle_switch/toggle_switch.dart';

class AddMasterfiles extends StatefulWidget {
  final int selectedIndex;
  final bool isMobile;
  const AddMasterfiles({
    Key? key,
    required this.selectedIndex,
    required this.isMobile,
  }) : super(key: key);

  @override
  _AddMasterfilesState createState() => _AddMasterfilesState();
}

class _AddMasterfilesState extends State<AddMasterfiles> {
  int _selectedIndex = 0;
  String _title = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedIndex = widget.selectedIndex;
      switch (_selectedIndex) {
        case 0:
          _title = "Add Administrator";
          break;
        case 1:
          _title = "Add Department";
          break;
        case 2:
          _title = "Add School Year";
          break;
        case 3:
          _title = "Add Supervisor";
          break;
        case 4:
          _title = "Add Course";
          break;
        case 5:
          _title = "Add Scholarship Type";
          break;
        case 6:
          _title = "Add Office Master";
          break;
        default:
          _title = "Add Scholarship Sub Type";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: Get.height * 1,
        width: widget.isMobile ? Get.width * 1 : Get.width * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: selectedMasterFile(),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectedMasterFile() {
    switch (_selectedIndex) {
      case 0:
        return const AddAdmin();
      case 1:
        return const AddDepartment();
      case 2:
        return const AddSchoolYear();
      case 3:
        return const AddSupervisor();
      case 4:
        return const AddCourse();
      case 5:
        return const AddScholarshipType();
      case 6:
        return const AddOfficeMaster();
      default:
        return const AddScholarshipSubType();
    }
  }
}

// --------------------------------------------------------------Add Admin
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

// --------------------------------------------------------------Add Department
class AddDepartment extends StatefulWidget {
  const AddDepartment({Key? key}) : super(key: key);

  @override
  _AddDepartmentState createState() => _AddDepartmentState();
}

class _AddDepartmentState extends State<AddDepartment> {
  final TextEditingController _departmentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void addDepartment() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Map<String, String> jsonData = {"department": _departmentController.text};
      Map<String, String> requestBody = {
        "json": jsonEncode(jsonData),
        "operation": "addDepartment",
      };
      var res = await http.post(
        Uri.parse("${SessionStorage.url}admin.php"),
        body: requestBody,
      );
      print("Res.body" + res.body);
      if (res.body == "-1") {
        ShowAlert().showAlert("error", "Department already exists");
      } else if (res.body == "1") {
        ShowAlert().showAlert("success", "Successfully added");
        _departmentController.clear();
      } else {
        ShowAlert().showAlert("error", "Failed to add");
        print("Res.body" + res.body);
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            width: Get.width * 0.5,
            child: MyTextField(
              labelText: "Department name*",
              controller: _departmentController,
              obscureText: false,
              willValidate: true,
              isEmail: false,
              isNumber: false,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                        if (_formKey.currentState!.validate()) {
                          addDepartment();
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

// --------------------------------------------------------------Add School Year
class AddSchoolYear extends StatefulWidget {
  const AddSchoolYear({Key? key}) : super(key: key);

  @override
  _AddSchoolYearState createState() => _AddSchoolYearState();
}

class _AddSchoolYearState extends State<AddSchoolYear> {
  TextEditingController _schoolYearController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // add school year function
  void addSchoolYear() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Map<String, String> jsonData = {"schoolYear": _schoolYearController.text};
      Map<String, String> requestBody = {
        "json": jsonEncode(jsonData),
        "operation": "addSchoolYear",
      };
      var res = await http.post(
        Uri.parse("${SessionStorage.url}admin.php"),
        body: requestBody,
      );
      if (res.body == "-1") {
        ShowAlert().showAlert("error", "School year already exists");
      } else if (res.body == "1") {
        ShowAlert().showAlert("success", "Successfully added");
        _schoolYearController.clear();
      } else {
        ShowAlert().showAlert("error", "Failed to add");
        print("Res.body" + res.body);
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
    return SizedBox(
      width: Get.width * 0.5,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              MyTextField(
                labelText: "School Year*",
                controller: _schoolYearController,
                obscureText: false,
                willValidate: true,
                isEmail: false,
                isNumber: true,
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                            if (_formKey.currentState!.validate()) {
                              addSchoolYear();
                            }
                          },
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// --------------------------------------------------------------AddSupervisor

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

// --------------------------------------------------------------AddCourse

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

// --------------------------------------------------------------AddScholarshipType

class AddScholarshipType extends StatefulWidget {
  const AddScholarshipType({Key? key}) : super(key: key);

  @override
  _AddScholarshipTypeState createState() => _AddScholarshipTypeState();
}

class _AddScholarshipTypeState extends State<AddScholarshipType> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _scholarshipNameController =
      TextEditingController();

  void addScholarshipType() async {
    setState(() {
      _isSubmitted = true;
    });

    try {
      Map<String, String> jsonData = {
        "scholarshipType": _scholarshipNameController.text
      };
      Map<String, String> requestBody = {
        "json": jsonEncode(jsonData),
        "operation": "addScholarShipType",
      };
      var res = await http.post(
        Uri.parse("${SessionStorage.url}admin.php"),
        body: requestBody,
      );

      if (res.body == "-1") {
        ShowAlert().showAlert("danger", "Scholarship type already exists");
      } else if (res.body == "1") {
        ShowAlert().showAlert("success", "Successfully added");
        _scholarshipNameController.clear();
      } else {
        ShowAlert().showAlert("danger", "Failed to add");
        print(res.body);
      }
    } catch (e) {
      ShowAlert().showAlert("danger", "Network error");
      print("Failed to add. Error: $e");
    } finally {
      setState(() {
        _isSubmitted = false;
      });
    }
  }

  bool _isLoading = false;
  bool _isSubmitted = false;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: _isLoading
            ? const LoadingSpinner()
            : Column(
                children: [
                  MyTextField(
                    labelText: "Scholarship Type Name*",
                    obscureText: false,
                    willValidate: true,
                    controller: _scholarshipNameController,
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
                                if (_formKey.currentState!.validate()) {
                                  addScholarshipType();
                                }
                              },
                            ),
                    ],
                  )
                ],
              ));
  }
}

// --------------------------------------------------------------AddOfficeMaster

class AddOfficeMaster extends StatefulWidget {
  const AddOfficeMaster({Key? key}) : super(key: key);

  @override
  _AddOfficeMasterState createState() => _AddOfficeMasterState();
}

class _AddOfficeMasterState extends State<AddOfficeMaster> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _officeNameController = TextEditingController();
  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _subjectCodeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  bool _isOffices = true;
  bool _isSubmitted = false;

  void addOfficeMaster() async {
    setState(() {
      _isSubmitted = true;
    });

    try {
      Map<String, String> officeData = {
        "officeName": _officeNameController.text,
      };
      Map<String, String> classData = {
        "className": _classNameController.text,
        "description": _descriptionController.text,
        "subjectCode": _subjectCodeController.text,
        "section": _sectionController.text,
        "room": _roomController.text,
      };

      Map<String, String> requestBody = {
        "json": jsonEncode(_isOffices ? officeData : classData),
        "operation": _isOffices ? "addOffice" : "addClass",
      };

      var res = await http.post(
        Uri.parse("${SessionStorage.url}admin.php"),
        body: requestBody,
      );

      if (res.body == "-1") {
        ShowAlert().showAlert(
            "danger", "${_isOffices ? "Office" : "Class"} name already exists");
      } else if (res.body == "1") {
        ShowAlert().showAlert("success", "Successfully added");
        _officeNameController.clear();
        _classNameController.clear();
        _descriptionController.clear();
        _sectionController.clear();
        _subjectCodeController.clear();
        _roomController.clear();
      } else {
        ShowAlert().showAlert("danger", "Failed to add");
        print(res.body);
      }
    } catch (e) {
      ShowAlert().showAlert("danger", "Network error");
    } finally {
      setState(() {
        _isSubmitted = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ToggleSwitch(
                centerText: true,
                fontSize: 15,
                initialLabelIndex: _isOffices ? 0 : 1,
                totalSwitches: 2,
                labels: const ['Offices', 'Classes'],
                onToggle: (index) {
                  print('switched to: $index');
                  setState(() {
                    _isOffices = index == 0 ? true : false;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: _isOffices ? officeForm() : classForm(),
            ),
            const SizedBox(height: 16),
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
                const SizedBox(width: 16),
                _isSubmitted
                    ? const LoadingSpinner()
                    : MyButton(
                        buttonText: "Submit",
                        buttonSize: 8,
                        color: Theme.of(context).colorScheme.tertiary,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            addOfficeMaster();
                          }
                        },
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget officeForm() {
    return Column(
      children: [
        MyTextField(
          labelText: "Office Name*",
          obscureText: false,
          willValidate: true,
          controller: _officeNameController,
          isNumber: false,
          isEmail: false,
        ),
      ],
    );
  }

  Widget classForm() {
    return Column(
      children: [
        MyTextField(
          labelText: "Class Name*",
          obscureText: false,
          willValidate: true,
          controller: _classNameController,
          isNumber: false,
          isEmail: false,
        ),
        const SizedBox(height: 24),
        MyTextField(
          labelText: "Subject Code*",
          obscureText: false,
          willValidate: true,
          controller: _subjectCodeController,
          isNumber: false,
          isEmail: false,
        ),
        const SizedBox(height: 24),
        MyTextField(
          labelText: "Descriptive Title*",
          obscureText: false,
          willValidate: true,
          controller: _descriptionController,
          isNumber: false,
          isEmail: false,
        ),
        const SizedBox(height: 24),
        MyTextField(
          labelText: "Section Name*",
          obscureText: false,
          willValidate: true,
          controller: _sectionController,
          isNumber: false,
          isEmail: false,
        ),
        const SizedBox(height: 24),
        MyTextField(
          labelText: "Room Name*",
          obscureText: false,
          willValidate: true,
          controller: _roomController,
          isNumber: false,
          isEmail: false,
        ),
      ],
    );
  }
}

// --------------------------------------------------------------AddScholarshipSubType

class AddScholarshipSubType extends StatefulWidget {
  const AddScholarshipSubType({Key? key}) : super(key: key);

  @override
  _AddScholarshipSubTypeState createState() => _AddScholarshipSubTypeState();
}

class _AddScholarshipSubTypeState extends State<AddScholarshipSubType> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeNameController = TextEditingController();
  final TextEditingController _maxHoursController = TextEditingController();
  bool _isLoading = true;
  bool _isSubmitted = false;
  int _selectedScholarshipType = 0;
  Map<int, String> scholarTypeMap = {};

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
        print("course map $scholarType");
      }
    } catch (e) {
      print("Failed to fetch scholarType data. Status code: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void addScholarSubType() async {
    setState(() {
      _isSubmitted = true;
    });
    try {
      Map<String, String> jsonData = {
        "scholarshipType": _selectedScholarshipType.toString(),
        "typeName": _typeNameController.text,
        "maxHours": _maxHoursController.text
      };
      Map<String, String> requestBody = {
        "operation": "addScholarSubType",
        "json": jsonEncode(jsonData),
      };
      print("jsondata: " + jsonData.toString());
      var res = await http.post(
        Uri.parse("${SessionStorage.url}admin.php"),
        body: requestBody,
      );

      if (res.body == "-1") {
        ShowAlert().showAlert("danger", "Sholarship sub type already exists");
      } else if (res.body == "1") {
        ShowAlert().showAlert("success", "Scholarship sub type added");
        _typeNameController.clear();
        _maxHoursController.clear();
        setState(() {
          _selectedScholarshipType = 0;
        });
      } else {
        ShowAlert().showAlert("danger", "Failed to add scholarship sub type");
        print("res.body" + res.body);
      }
    } catch (e) {
      ShowAlert().showAlert("danger", "Network Error");
      print("Failed to fetch course data. Error: $e");
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
    getScholarshipType();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: _isLoading ? const LoadingSpinner() : _scholarshipSubTypeForm());
  }

  Widget _scholarshipSubTypeForm() {
    return Column(
      children: [
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
          dropdownColor: Theme.of(context).colorScheme.onInverseSurface,
          icon: const Icon(
            Icons.keyboard_arrow_down_outlined,
            color: Colors.white,
          ),
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
            labelText: 'Scholarship Type *',
            labelStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 16),
        MyTextField(
          labelText: "Scholarship sub type name",
          obscureText: false,
          willValidate: true,
          controller: _typeNameController,
          isNumber: false,
          isEmail: false,
        ),
        const SizedBox(height: 16),
        MyTextField(
          labelText: "Max hours",
          obscureText: false,
          willValidate: true,
          controller: _maxHoursController,
          isNumber: true,
          isEmail: false,
        ),
        const SizedBox(height: 16),
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
                      if (_formKey.currentState!.validate()) {
                        addScholarSubType();
                      }
                    },
                  ),
          ],
        )
      ],
    );
  }
}
