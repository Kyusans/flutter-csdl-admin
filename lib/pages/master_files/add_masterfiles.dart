import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/pages/master_files/add_admin.dart';
import 'package:flutter_csdl_admin/pages/master_files/add_course.dart';
import 'package:flutter_csdl_admin/pages/master_files/add_department.dart';
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Get.width * 0.5
            SizedBox(
              height: 600,
              width: widget.isMobile ? Get.width * 1 : Get.width * 0.3,
              child: Card(
                elevation: 5,
                color: Theme.of(context).colorScheme.onPrimary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: selectedMasterFile(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectedMasterFile() {
    switch (_selectedIndex) {
      case 0:
        return AddAdmin();
      case 1:
        return AddDepartment();
      case 2:
        return AddSchoolYear();
      case 3:
        return AddSupervisor();
      case 4:
        return AddCourse();
      case 5:
        return AddScholarshipType();
      default:
        return Text("Add scholarship sub type");
    }
  }
}
