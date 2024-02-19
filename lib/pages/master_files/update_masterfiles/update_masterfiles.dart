import 'package:flutter/material.dart';

class UpdateMasterfiles extends StatefulWidget {
  final dynamic selectedMasterFile;
  final dynamic masterfileId;
  const UpdateMasterfiles({
    Key? key,
    required this.masterfileId,
    this.selectedMasterFile,
  }) : super(key: key);

  @override
  _UpdateMasterfilesState createState() => _UpdateMasterfilesState();
}

class _UpdateMasterfilesState extends State<UpdateMasterfiles> {
  @override
  Widget build(BuildContext context) {
    return _selectedIndex();
  }

  Widget _selectedIndex() {
    switch (widget.selectedMasterFile) {
      case "Department":
        return UpdateDepartment(
          departmentId: widget.masterfileId,
        );
      default:
        return Text("Mali ka Lmao");
    }
  }
}

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
