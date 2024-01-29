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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.labelText,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      MyButton(
                        buttonText: "Add",
                        buttonSize: 5,
                        color: Theme.of(context).colorScheme.tertiary,
                        onPressed: widget.onPressed,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      MyButton(
                        buttonText: "Get List",
                        buttonSize: 5,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        onPressed: () {},
                      ),
                    ],
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
