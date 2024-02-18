import 'package:flutter/material.dart';

class UpdateDepartment extends StatefulWidget {
  final dynamic departmentId;
  const UpdateDepartment({
    Key? key,
    required this.departmentId,
  }) : super(key: key);

  @override
  _UpdateDepartmentState createState() => _UpdateDepartmentState();
}

class _UpdateDepartmentState extends State<UpdateDepartment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Update Department"),
      ],
    );
  }
}
