import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/pages/master_files/add_admin.dart';

class AddMasterfiles extends StatefulWidget {
  final int selectedIndex;
  const AddMasterfiles({
    Key? key,
    required this.selectedIndex,
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
        case 7:
          _title = "Add office";
          break;
        default:
          _title = "Add Scholarship Sub Type";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text(
              _title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
          ),
          const SizedBox(height: 16),
          selectedMasterFile(),
        ],
      ),
    );
  }

  Widget selectedMasterFile() {
    switch (_selectedIndex) {
      case 0:
        return AddAdmin();
      case 1:
        return Container();
      default:
        return Text("Add scholarship sub type");
    }
  }
}
