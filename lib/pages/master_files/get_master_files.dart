import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/loading_spinner.dart';
import 'package:flutter_csdl_admin/local_storage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:flutter_csdl_admin/session_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_csdl_admin/pages/master_files/show_alert.dart';

class GetMasterFiles extends StatefulWidget {
  final int selectedIndex;
  final bool isMobile;
  const GetMasterFiles({
    Key? key,
    required this.selectedIndex,
    required this.isMobile,
  }) : super(key: key);

  @override
  _GetMasterFilesState createState() => _GetMasterFilesState();
}

class _GetMasterFilesState extends State<GetMasterFiles> {
  late LocalStorage _localStorage;
  String _userId = "";
  int _selectedIndex = 0;
  List<dynamic> masterFiles = [];
  String _title = "";
  String _tableName = "";
  String _orderBy = "";
  @override
  void initState() {
    super.initState();
    _localStorage = LocalStorage();
    _initializeLocalStorage();
    setState(() {
      _selectedIndex = widget.selectedIndex;
      switch (_selectedIndex) {
        case 0:
          // _title = widget.isMobile.toString();
          _title = "Administrators";
          _tableName = "tbl_admin";
          _orderBy = "adm_name";
          break;
        case 1:
          _title = "Department";
          _tableName = "tbl_departments";
          _orderBy = "dept_name";
          break;
        case 2:
          _title = "School Year";
          _tableName = "tbl_sy";
          _orderBy = "sy_name";
          break;
        case 3:
          _title = "Supervisors";
          _tableName = "tbl_supervisors_master";
          _orderBy = "supM_name";
          break;
        case 4:
          _title = "Course";
          _tableName = "tbl_course";
          _orderBy = "crs_name";
          break;
        case 5:
          _title = "Scholarship Type";
          _tableName = "tbl_scholarship_type";
          _orderBy = "type_name";

          break;
        case 6:
          _title = "Office Master";
          _tableName = "tbl_office_master";
          _orderBy = "off_name";
          break;
        default:
          _title = "Scholarship Sub Type";
          _tableName = "tbl_scholarship_sub_type";
          _orderBy = "stype_name";
      }
    });
  }

  void _initializeLocalStorage() async {
    await _localStorage.init();
    setState(() {
      _userId = _localStorage.getValue("employeeId");
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    List masterFilesList = await _getMasterFiles();
    if (mounted) {
      setState(() {
        masterFiles = masterFilesList;
      });
    }
    print("masterfiles mo to: " + masterFilesList.toString());
  }

  Future<List> _getMasterFiles() async {
    try {
      var url = Uri.parse("${SessionStorage.url}admin.php");
      Map<String, String> jsonData = {
        "tableName": _tableName,
        "orderBy": _orderBy,
      };
      Map<String, String> requestBody = {
        "json": jsonEncode(jsonData),
        "operation": "getList",
      };
      print("jsondata" + jsonData.toString());
      print("requestbody" + requestBody.toString());

      var res = await http.post(url, body: requestBody);
      print("res mo to: " + res.body.toString());
      return res.body != "0" ? jsonDecode(res.body) : [];
    } catch (e) {
      ShowAlert().showAlert("danger", "Network error");
      print("error mo to" + e.toString());
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: SizedBox(
          height: Get.height * 1,
          width: Get.width * 1,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // IconButton(
                  //   onPressed: () => Get.back(),
                  //   icon: const Icon(
                  //     Icons.arrow_back_ios,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        _title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 64),
              FutureBuilder(
                  future: _getMasterFiles(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoadingSpinner(),
                          ],
                        );
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return masterFilesList();
                      default:
                        return Text(snapshot.error.toString());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget masterFilesList() {
    if (masterFiles.isEmpty) {
      return const Center(
        child: Text(
          "No data found",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: masterFiles.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          bool isCurrentUser = masterFiles[index]["adm_employee_id"] == _userId;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Slidable(
              startActionPane: isCurrentUser
                  ? null
                  : ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            print(masterFiles[index]["adm_id"]);
                          },
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            print(masterFiles[index]["adm_id"]);
                          },
                          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                          foregroundColor: Colors.white,
                          icon: Icons.update,
                          label: 'Update',
                        ),
                      ],
                    ),
              child: Container(
                color: Theme.of(context).colorScheme.tertiary,
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    masterFiles[index][_orderBy] + (isCurrentUser ? " (You)" : ""),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
