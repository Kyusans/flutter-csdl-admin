import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  final List<String> items;
  final String labelText;
  final String value;
  final void Function(String?)? onChange;

  const MyDropdown({
    Key? key,
    required this.items,
    required this.labelText,
    required this.value,
    this.onChange,
  }) : super(key: key);

  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(
          5.0,
        ),
      ),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: widget.value,
            items: widget.items.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e),
              );
            }).toList(),
            onChanged: widget.onChange,
          ),
        ),
      ),
    );
  }
}
