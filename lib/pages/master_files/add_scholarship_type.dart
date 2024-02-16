import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/loading_spinner.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
import 'package:flutter_csdl_admin/components/my_textfield.dart';
import 'package:flutter_csdl_admin/pages/master_files/show_alert.dart';
import 'package:flutter_csdl_admin/session_storage.dart';
import 'package:http/http.dart' as http;

class AddScholarshipType extends StatefulWidget {
  const AddScholarshipType({Key? key}) : super(key: key);

  @override
  _AddScholarshipTypeState createState() => _AddScholarshipTypeState();
}

class _AddScholarshipTypeState extends State<AddScholarshipType> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _scholarshipNameController = TextEditingController();

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
