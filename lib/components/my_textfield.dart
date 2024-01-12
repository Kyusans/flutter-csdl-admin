import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String labelText;
  final bool obscureText;
  final bool willValidate;
  final bool isNumber;
  final TextEditingController controller;
  final Icon? icon;

  const MyTextField({
    Key? key,
    required this.labelText,
    required this.obscureText,
    required this.willValidate,
    required this.controller,
    required this.isNumber,
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
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.onInverseSurface,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade600,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        prefixIcon: widget.icon,
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                color: Theme.of(context).colorScheme.secondary,
                icon: _isObscure
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              )
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty && widget.willValidate) {
          return "This field is required";
        } else if (widget.isNumber) {
          if (double.tryParse(value) == null) {
            return "Please enter a valid number";
          }
        }
        return null;
      },
    );
  }
}
