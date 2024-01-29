import 'dart:convert';
import 'package:flutter_csdl_admin/session_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/loading_spinner.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
import 'package:flutter_csdl_admin/components/my_textfield.dart';
import 'package:get/get.dart';

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
        Get.snackbar(
          "Error",
          "School year already exists",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      } else if (res.body == "1") {
        Get.snackbar(
          "Success",
          "Successfully added",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
        _schoolYearController.clear();
      } else {
        Get.snackbar(
          "Error",
          "Something went wrong",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
        print("Res.body" + res.body);
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Network error",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            MyTextField(
              labelText: "School Year",
              controller: _schoolYearController,
              obscureText: false,
              willValidate: true,
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
    );
  }
}
