import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
import 'package:flutter_csdl_admin/components/my_textfield.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
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
                labelText: "Username*",
                obscureText: false,
                willValidate: true,
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
                obscureText: false,
                willValidate: true,
                controller: _passwordController,
                isNumber: false,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: MyTextField(
                labelText: "Confirm Password*",
                obscureText: false,
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
                Navigator.pop(context);
                Get.toNamed("/dashboard");
              },
            ),
            const SizedBox(
              width: 16,
            ),
            MyButton(
              buttonText: "Submit",
              buttonSize: 8,
              color: Theme.of(context).colorScheme.tertiary,
              onPressed: () {},
            )
          ],
        )
      ],
    );
  }
}
