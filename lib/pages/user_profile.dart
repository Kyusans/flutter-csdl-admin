import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
import 'package:flutter_csdl_admin/components/my_textfield.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _confirmEmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 4,
          color: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text(
                      "Image",
                      style: TextStyle(fontSize: 30),
                    ),
                    // SizedBox(
                    //   width: 16,
                    // ),
                    // Text(
                    //   "Upload New Photo",
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ],
                ),
                MyButton(
                  buttonText: "Update Photo",
                  buttonSize: 8,
                  color: Theme.of(context).colorScheme.tertiary,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Card(
          elevation: 4,
          color: Theme.of(context).colorScheme.onPrimary,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 64.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: MyTextField(
                          labelText: "Full Name*",
                          obscureText: false,
                          willValidate: true,
                          controller: _fullNameController,
                          isNumber: false,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: MyTextField(
                          labelText: "User ID*",
                          obscureText: false,
                          willValidate: true,
                          controller: _userIdController,
                          isNumber: false,
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: MyTextField(
                          labelText: "Password*",
                          obscureText: false,
                          willValidate: true,
                          controller: _passwordController,
                          isNumber: false,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: MyTextField(
                          labelText: "Confirm Password*",
                          obscureText: false,
                          willValidate: true,
                          controller: _confirmPasswordController,
                          isNumber: false,
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: MyTextField(
                          labelText: "Email Address*",
                          obscureText: false,
                          willValidate: true,
                          controller: _emailController,
                          isNumber: false,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: MyTextField(
                          labelText: "Confirm Email Address*",
                          obscureText: false,
                          willValidate: true,
                          controller: _confirmEmailController,
                          isNumber: false,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      child: MyButton(
                        buttonText: "Update Info",
                        buttonSize: 12,
                        color: Theme.of(context).colorScheme.tertiary,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
