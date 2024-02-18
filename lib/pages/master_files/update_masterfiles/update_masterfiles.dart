import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/pages/master_files/update_masterfiles/update_department.dart';

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
