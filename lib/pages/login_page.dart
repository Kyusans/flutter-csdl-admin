import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController userIdController = TextEditingController();

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
            SizedBox(
              height: 8,
            ),
            Text(
              "L O G I N",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
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
                    icon: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  MyTextField(
                    labelText: "Login",
                    obscureText: false,
                    controller: userIdController,
                    icon: Icon(
                      Icons.lock,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
