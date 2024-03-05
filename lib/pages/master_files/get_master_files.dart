import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_csdl_admin/components/loading_spinner.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
import 'package:flutter_csdl_admin/components/read_only_input.dart';
import 'package:flutter_csdl_admin/local_storage.dart';
import 'package:flutter_csdl_admin/pages/master_files/update_masterfiles/update_masterfiles.dart';
import 'package:get/get.dart';
import 'package:flutter_csdl_admin/session_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_csdl_admin/components/show_alert.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class GetMasterFiles extends StatefulWidget {
  final int selectedIndex;
  const GetMasterFiles({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  _GetMasterFilesState createState() => _GetMasterFilesState();
}

class _GetMasterFilesState extends State<GetMasterFiles> {
  late LocalStorage _localStorage;
  int _selectedIndex = 0;
  List<dynamic> masterFiles = [];
  Map<String, dynamic> _selectedMasterFile = {};
  String _title = "";
  String _tableName = "";
  String _masterFileName = "";
  String _masterfileId = "";
  String _userId = "";
  bool _isSubmitting = false;
  bool _isLoading = true;
  bool _hasSelected = false;
  // bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    _localStorage = LocalStorage();
    _initializeLocalStorage();

    setState(() {
      _selectedIndex = widget.selectedIndex;
      switch (_selectedIndex) {
        case 0:
          _title = "Administrators";
          _tableName = "tbl_admin";
          _masterFileName = "adm_name";
          _masterfileId = "adm_id";
          break;
        case 1:
          _title = "Department";
          _tableName = "tbl_departments";
          _masterFileName = "dept_name";
          _masterfileId = "dept_id";
          break;
        case 2:
          _title = "School Year";
          _tableName = "tbl_sy";
          _masterFileName = "sy_name";
          _masterfileId = "st_id";
          break;
        case 3:
          _title = "Supervisors";
          _tableName = "tbl_supervisors_master";
          _masterFileName = "supM_name";
          _masterfileId = "supM_id";
          break;
        case 4:
          _title = "Course";
          _tableName = "tbl_course";
          _masterFileName = "crs_name";
          _masterfileId = "crs_id";
          break;
        case 5:
          _title = "Scholarship Type";
          _tableName = "tbl_scholarship_type";
          _masterFileName = "type_name";
          _masterfileId = "type_id";
          break;
        case 6:
          _title = "Office Master";
          _tableName = "tbl_office_master";
          _masterFileName = "off_name";
          _masterfileId = "off_id";
          break;
        default:
          _title = "Scholarship Sub Type";
          _tableName = "tbl_scholarship_sub_type";
          _masterFileName = "stype_name";
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
    _loadData();
  }

  void _loadData() async {
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
      Map<String, dynamic> jsonData = {
        "tableName": _tableName,
        "orderBy": _masterFileName,
      };
      Map<String, dynamic> requestBody = {
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
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      bounce: true,
      enableDrag: true,
      builder: (context) {
        return SizedBox(
          height: Get.height * 0.8,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              var uri =
                                  Uri.parse("${SessionStorage.url}admin.php");

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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: SizedBox(
          height: Get.height * 1,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
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
              ),
              const SizedBox(height: 64),
              _isLoading
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingSpinner(),
                      ],
                    )
                  : searchMasterFiles(),
              const SizedBox(height: 16),
              _hasSelected
                  ? Expanded(
                      child: SizedBox(
                        key: UniqueKey(),
                        width: Get.width * 0.9,
                        child: Card(
                          color: Theme.of(context).colorScheme.onInverseSurface,
                          child: selectedMasterFile(),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchMasterFiles() {
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: Theme.of(context).colorScheme.onInverseSurface,
      labelText: "Search $_title",
      labelStyle: const TextStyle(color: Colors.white),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.onInverseSurface,
        ),
      ),
    );

    return SizedBox(
      width: Get.width * 0.9,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              width: Get.width * 0.9,
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return Future.value(
                    masterFiles
                        .map<String>((dynamic value) =>
                            value[_masterFileName].toString())
                        .where((String value) => value.toLowerCase().contains(
                              textEditingValue.text.toLowerCase(),
                            )),
                  );
                },
                onSelected: (String selectedValue) {
                  var selectedObject = masterFiles.firstWhere(
                    (element) =>
                        element[_masterFileName].toString() == selectedValue,
                  );
                  print(selectedObject);
                  setState(() {
                    _hasSelected = true;
                    _selectedMasterFile = selectedObject;
                  });
                  print("selectedMasterFile ${_selectedMasterFile}");
                },
                fieldViewBuilder: (context, textEditingController, focusNode,
                    onFieldSubmitted) {
                  return TextFormField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    onFieldSubmitted: (value) {},
                    decoration: inputDecoration,
                  );
                },
                optionsViewBuilder: (context, Function(String) onSelected,
                    Iterable<String> options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                      elevation: 4.0,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: Get.width * 0.9,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(
                                options.elementAt(index),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                onSelected(
                                  options.elementAt(index),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
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
        return selectedAdmin();
      case 1:
        return selectedDepartment();
      case 2:
        return selectedSchoolYear();
      case 3:
        return selectedSupervisor();
      case 4:
        return selectedCourse();
      case 5:
        return selectedScholarshipType();
      case 6:
        return selectedOfficeMaster();
      default:
        return selectedScholarshipSubType();
    }
  }

  Widget selectedAdmin() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ReadOnlyInput(
            initialValue: _selectedMasterFile["adm_name"],
            labelText: "Full Name",
          )
        ],
      ),
    );
  }

  Widget selectedDepartment() {
    return const Text("Selected Department");
  }

  Widget selectedSchoolYear() {
    return const Text("Selected School Year");
  }

  Widget selectedSupervisor() {
    return const Text("Selected Supervisor");
  }

  Widget selectedCourse() {
    return const Text("Selected Course");
  }

  Widget selectedScholarshipType() {
    return const Text("Selected Scholarship Type");
  }

  Widget selectedOfficeMaster() {
    return const Text("Selected Office Master");
  }

  Widget selectedScholarshipSubType() {
    return const Text("Selected Scholarship Sub Type");
  }
}
