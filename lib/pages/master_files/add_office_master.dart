import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/loading_spinner.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
import 'package:flutter_csdl_admin/components/my_textfield.dart';
import 'package:flutter_csdl_admin/pages/master_files/show_alert.dart';
import 'package:flutter_csdl_admin/session_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:toggle_switch/toggle_switch.dart';

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
        ShowAlert().showAlert("danger", "${_isOffices ? "Office" : "Class"} name already exists");
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
                labels: const [
                  'Offices',
                  'Classes'
                ],
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
                // MyButton(
                //   buttonText: "Back",
                //   buttonSize: 8,
                //   color: Colors.red,
                //   onPressed: () {
                //     Get.back();
                //   },
                // ),
                // const SizedBox(width: 16),
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
