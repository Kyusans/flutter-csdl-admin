import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/pages/master_files/add_admin.dart';
import 'package:flutter_csdl_admin/pages/master_files/add_course.dart';
import 'package:flutter_csdl_admin/pages/master_files/add_department.dart';
import 'package:flutter_csdl_admin/pages/master_files/add_office_master.dart';
import 'package:flutter_csdl_admin/pages/master_files/add_scholarship_sub_type.dart';
import 'package:flutter_csdl_admin/pages/master_files/add_scholarship_type.dart';
import 'package:flutter_csdl_admin/pages/master_files/add_school_year.dart';
import 'package:flutter_csdl_admin/pages/master_files/add_supervisor.dart';
import 'package:get/get.dart';

class AddMasterfiles extends StatefulWidget {
  final int selectedIndex;
  final bool isMobile;
  const AddMasterfiles({
    Key? key,
    required this.selectedIndex,
    required this.isMobile,
  }) : super(key: key);

  @override
  _AddMasterfilesState createState() => _AddMasterfilesState();
}

class _AddMasterfilesState extends State<AddMasterfiles> {
  int _selectedIndex = 0;
  String _title = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedIndex = widget.selectedIndex;
      switch (_selectedIndex) {
        case 0:
          _title = "Add Administrator";
          break;
        case 1:
          _title = "Add Department";
          break;
        case 2:
          _title = "Add School Year";
          break;
        case 3:
          _title = "Add Supervisor";
          break;
        case 4:
          _title = "Add Course";
          break;
        case 5:
          _title = "Add Scholarship Type";
          break;
        case 6:
          _title = "Add Office Master";
          break;
        default:
          _title = "Add Scholarship Sub Type";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: Get.height * 1,
        width: widget.isMobile ? Get.width * 1 : Get.width * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: selectedMasterFile(),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectedMasterFile() {
    switch (_selectedIndex) {
      case 0:
        return const AddAdmin();
      case 1:
        return const AddDepartment();
      case 2:
        return const AddSchoolYear();
      case 3:
        return const AddSupervisor();
      case 4:
        return const AddCourse();
      case 5:
        return const AddScholarshipType();
      case 6:
        return const AddOfficeMaster();
      default:
        return const AddScholarshipSubType();
    }
  }
}
