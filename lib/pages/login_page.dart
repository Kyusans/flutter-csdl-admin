import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/myButton.dart';
import 'package:flutter_csdl_admin/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "L O G I N",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 8,
            ),

            // Textfields
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  MyTextField(
                    labelText: "UserId",
                    obscureText: false,
                    controller: userIdController,
                    icon: null,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyTextField(
                    labelText: "Password",
                    obscureText: true,
                    controller: passwordController,
                    icon: null,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MyButton(
                      buttonText: "Login",
                      buttonSize: 24,
                      onPressed: () {
                        print("print mo to");
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
