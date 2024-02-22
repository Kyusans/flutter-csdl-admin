import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/loading_spinner.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
import 'package:flutter_csdl_admin/local_storage.dart';
import 'package:flutter_csdl_admin/pages/master_files/update_masterfiles/update_masterfiles.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:flutter_csdl_admin/session_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_csdl_admin/components/show_alert.dart';

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
  int _selectedIndex = 0;
  List<dynamic> masterFiles = [];
  String _title = "";
  String _tableName = "";
  String _orderBy = "";
  String _masterfileId = "";
  String _userId = "";
  bool _isSubmitting = false;
  bool _isLoading = true;

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
          _masterfileId = "adm_id";
          break;
        case 1:
          _title = "Department";
          _tableName = "tbl_departments";
          _orderBy = "dept_name";
          _masterfileId = "dept_id";
          break;
        case 2:
          _title = "School Year";
          _tableName = "tbl_sy";
          _orderBy = "sy_name";
          _masterfileId = "st_id";
          break;
        case 3:
          _title = "Supervisors";
          _tableName = "tbl_supervisors_master";
          _orderBy = "supM_name";
          _masterfileId = "supM_id";
          break;
        case 4:
          _title = "Course";
          _tableName = "tbl_course";
          _orderBy = "crs_name";
          _masterfileId = "crs_id";
          break;
        case 5:
          _title = "Scholarship Type";
          _tableName = "tbl_scholarship_type";
          _orderBy = "type_name";
          _masterfileId = "type_id";

          break;
        case 6:
          _title = "Office Master";
          _tableName = "tbl_office_master";
          _orderBy = "off_name";
          _masterfileId = "off_id";
          break;
        default:
          _title = "Scholarship Sub Type";
          _tableName = "tbl_scholarship_sub_type";
          _orderBy = "stype_name";
          _masterfileId = "stype_id";
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
        _isLoading = false;
      });
    }
    print("masterfiles mo to: " + masterFilesList.toString());
  }

  void _handleUpdateMasterfiles(masterfileIndex, masterFileId) {
    Get.dialog(
      AlertDialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.3,
          vertical: Get.width * 0.05,
        ),
        content: UpdateMasterfiles(
          selectedMasterFile: masterfileIndex,
          masterfileId: masterFileId,
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 0,
      ),
    );
  }

  void _handleSetActive(schoolYearId, syName) async {
    Get.dialog(
      AlertDialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.3,
          vertical: Get.height * 0.3,
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  "Are you sure you want to activate $syName?",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            _isSubmitting
                ? const LoadingSpinner()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        buttonText: "Cancel",
                        buttonSize: 8,
                        color: Colors.red,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      const SizedBox(width: 8),
                      MyButton(
                        buttonText: "Activate",
                        buttonSize: 8,
                        color: Theme.of(context).colorScheme.tertiary,
                        onPressed: () async {
                          setState(() {
                            _isSubmitting = true;
                          });
                          var uri = Uri.parse("${SessionStorage.url}admin.php");

                          try {
                            Map<String, dynamic> requestBody = {
                              "schoolYearId": schoolYearId
                            };
                            Map<String, dynamic> jsonData = {
                              "operation": "setSYActive",
                              "json": jsonEncode(requestBody),
                            };
                            var res = await http.post(uri, body: jsonData);
                            if (res.body == "1") {
                              ShowAlert().showAlert(
                                  "success", "Successfully activated");

                              await _refreshData();
                            } else {
                              ShowAlert()
                                  .showAlert("error", "Failed to activate");
                              print("Res mo to: ${res.body}");
                            }
                          } catch (e) {
                            ShowAlert().showAlert("error", "Network error");
                            print(e);
                          } finally {
                            setState(() {
                              _isSubmitting = false;
                            });
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    setState(() {
      _isLoading = true;
    });
    List masterFilesList = await _getMasterFiles();
    if (mounted) {
      setState(() {
        masterFiles = masterFilesList;
        _isLoading = false;
      });
    }
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

      var res = await http.post(url, body: requestBody);
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
          width: widget.isMobile ? Get.width * 1 : Get.width * 0.5,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
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
              _isLoading
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingSpinner(),
                      ],
                    )
                  : masterFilesList(),
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
          bool isAdminList = _title == "Administrators";
          bool isSchoolYearList = _title == "School Year";
          bool isCurrentUser = masterFiles[index]["adm_employee_id"] == _userId;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Slidable(
              startActionPane: isAdminList
                  ? ActionPane(motion: const BehindMotion(), children: [
                      SlidableAction(
                        onPressed: (context) {},
                        backgroundColor: const Color(0xFFFE4A49),
                        label: isCurrentUser
                            ? "You cant change your personal details here"
                            : "You cant change his/her personal details",
                      )
                    ])
                  : ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        // delete
                        !isSchoolYearList
                            ? SlidableAction(
                                onPressed: (context) {
                                  // delete mo to
                                },
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              )
                            :
                            // set active
                            SlidableAction(
                                onPressed: (context) {
                                  if (masterFiles[index]["sy_status"] == 1) {
                                    ShowAlert()
                                        .showAlert("info", "Already Active");
                                  } else {
                                    _handleSetActive(
                                        masterFiles[index]["sy_id"],
                                        masterFiles[index]["sy_name"]);
                                  }
                                },
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                foregroundColor: Colors.white,
                                icon: masterFiles[index]["sy_status"] == 1
                                    ? Icons.check_circle_outline
                                    : Icons.check_outlined,
                                label: masterFiles[index]["sy_status"] == 1
                                    ? 'Already Active'
                                    : 'Set active',
                              ),
                        // update
                        SlidableAction(
                          onPressed: (context) {
                            _handleUpdateMasterfiles(_title, _masterfileId);
                            print(masterFiles[index]["adm_id"]);
                          },
                          backgroundColor:
                              Theme.of(context).colorScheme.onInverseSurface,
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
                    '${masterFiles[index][_orderBy]} ${masterFiles[index]['sy_status'] == 1 ? "(Currently Active)" : ""}',
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
