import 'package:flutter/material.dart';

class ReadOnlyInput extends StatefulWidget {
  final String initialValue;
  final String labelText;
  const ReadOnlyInput({
    Key? key,
    required this.initialValue,
    required this.labelText,
  }) : super(key: key);

  @override
  _ReadOnlyInputState createState() => _ReadOnlyInputState();
}

class _ReadOnlyInputState extends State<ReadOnlyInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      initialValue: widget.initialValue,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: Colors.white),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
      ),
    );
  }
}
