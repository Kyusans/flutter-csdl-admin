import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final Icon? icon;

  const MyTextField({
    Key? key,
    required this.labelText,
    required this.obscureText,
    required this.controller,
    this.icon,
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscure,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(7),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(7),
            ),
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          prefixIcon: widget.icon,
          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  color: Theme.of(context).colorScheme.inversePrimary,
                  icon: _isObscure
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                )
              : null),
    );
  }
}
