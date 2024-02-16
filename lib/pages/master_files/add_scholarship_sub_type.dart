import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/loading_spinner.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
import 'package:flutter_csdl_admin/components/my_textfield.dart';
import 'package:flutter_csdl_admin/pages/master_files/show_alert.dart';
import 'package:flutter_csdl_admin/session_storage.dart';
import 'package:http/http.dart' as http;

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
      Map<String, String> requestBody = {
        "operation": "getScholarshipType"
      };
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
    return Form(key: _formKey, child: _isLoading ? const LoadingSpinner() : _scholarshipSubTypeForm());
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
