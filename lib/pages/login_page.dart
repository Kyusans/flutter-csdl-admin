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
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check the available width to determine the layout
          if (constraints.maxWidth > 1300) {
            return Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "T E X T  M O T O",
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 100, horizontal: 400),
                    child: Padding(
                      padding: const EdgeInsets.all(100),
                      child: _buildLoginSection(context),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // For smaller screens (like mobile phones)
            return _buildLoginSection(context);
          }
        },
      ),
    );
  }

  Widget _buildLoginSection(context) {
    return Center(
      child: Card(
        elevation: 5,
        color: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 8),
              const Text(
                "S I G N  I N",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    MyTextField(
                      labelText: "UserId",
                      obscureText: false,
                      controller: userIdController,
                      icon: null,
                    ),
                    const SizedBox(height: 16),
                    MyTextField(
                      labelText: "Password",
                      obscureText: true,
                      controller: passwordController,
                      icon: null,
                    ),
                    const SizedBox(height: 16),
                    MyButton(
                      buttonText: "Login",
                      buttonSize: 24,
                      onPressed: () {
                        print("print mo to");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
