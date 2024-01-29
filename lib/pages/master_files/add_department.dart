import 'dart:convert';
import 'package:flutter_csdl_admin/session_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/loading_spinner.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
import 'package:flutter_csdl_admin/components/my_textfield.dart';
import 'package:get/get.dart';

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
        Get.snackbar(
          "Error",
          "Department already exists",
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
        _departmentController.clear();
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
      Get.snackbar("Network Error", "Something went wrong");
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
            width: Get.width * 0.2,
            child: MyTextField(
              labelText: "Department name",
              controller: _departmentController,
              obscureText: false,
              willValidate: true,
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
