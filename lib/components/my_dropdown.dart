import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  final List<String> items;
  final String value;
  final void Function(String?)? onChange;

  const MyDropdown({
    Key? key,
    required this.items,
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
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        ),
      ),
      child: DropdownButtonFormField2<String>(
        iconStyleData: const IconStyleData(
          icon: Padding(
            padding: EdgeInsets.only(right: 4.0),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
          ),
        ),
        isExpanded: true,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 24),
          border: InputBorder.none,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        value: widget.value,
        onChanged: widget.onChange,
        items: widget.items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
