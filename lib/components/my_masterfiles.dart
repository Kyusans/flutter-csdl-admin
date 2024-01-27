import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';

class MyMasterfiles extends StatefulWidget {
  final String topText;
  final String labelText;
  final void Function() onPressed;

  const MyMasterfiles({
    Key? key,
    required this.topText,
    required this.labelText,
    required this.onPressed,
  }) : super(key: key);

  @override
  _MyMasterfilesState createState() => _MyMasterfilesState();
}

class _MyMasterfilesState extends State<MyMasterfiles> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.topText,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 4,
          ),
          Card(
            color: Theme.of(context).colorScheme.onInverseSurface,
            elevation: 6,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.labelText),
                  const SizedBox(
                    width: 16,
                  ),
                  MyButton(
                    buttonText: "Click me",
                    buttonSize: 4,
                    color: Theme.of(context).colorScheme.tertiary,
                    onPressed: widget.onPressed,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
