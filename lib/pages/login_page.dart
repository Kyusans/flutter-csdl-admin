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
          if (constraints.maxWidth > 1300) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(200, 100, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "SAMS",
                        style: TextStyle(
                          fontSize: 150,
                        ),
                      ),
                      Text(
                        "School Attendance",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        "Monitoring System",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(650, 0, 50, 250),
                    child: _buildLoginSection(context),
                  ),
                ),
              ],
            );
          } else {
            return _buildLoginSection(context);
          }
        },
      ),
    );
  }

  Widget _buildLoginSection(context) {
    return Center(
      child: SingleChildScrollView(
        child: Card(
          elevation: 5,
          color: const Color.fromARGB(175, 49, 49, 49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 75),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Sign in your account",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
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
      ),
    );
  }
}
