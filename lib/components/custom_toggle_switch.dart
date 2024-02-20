import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';

class CustomToggleSwitch extends StatefulWidget {
  final List<String> labels;
  final Function(int) onToggle;
  final int initialLabelIndex;

  const CustomToggleSwitch({
    Key? key,
    required this.labels,
    required this.onToggle,
    this.initialLabelIndex = 0,
  }) : super(key: key);

  @override
  _CustomToggleSwitchState createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialLabelIndex;
  }

  @override
  Widget build(BuildContext context) {
    final newIndex = _selectedIndex == 0 ? 1 : 0;

    void toggleSwitch() {
      setState(() {
        _selectedIndex = newIndex;
      });
      widget.onToggle(newIndex);
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyButton(
            buttonText: _selectedIndex == 0
                ? "${widget.labels[1]} >"
                : "< ${widget.labels[0]}",
            color: Theme.of(context).colorScheme.tertiary,
            buttonSize: 8,
            onPressed: () {
              toggleSwitch();
            },
          ),
        ],
      ),
    );
  }
}
