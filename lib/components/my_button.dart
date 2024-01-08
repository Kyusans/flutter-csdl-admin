import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final String buttonText;
  final double buttonSize;
  final Color color;
  final void Function()? onPressed;

  const MyButton({
    Key? key,
    required this.buttonText,
    required this.buttonSize,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: widget.color,
      onPressed: widget.onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(widget.buttonSize),
        child: Center(
          child: Text(
            widget.buttonText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
