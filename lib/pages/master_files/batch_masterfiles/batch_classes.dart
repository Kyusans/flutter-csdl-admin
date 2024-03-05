import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_csdl_admin/components/loading_spinner.dart';
import 'package:flutter_csdl_admin/components/my_button.dart';
import 'package:flutter_csdl_admin/components/show_alert.dart';
import 'package:flutter_csdl_admin/session_storage.dart';

class BatchClasses extends StatefulWidget {
  const BatchClasses({Key? key}) : super(key: key);

  @override
  _BatchClassesState createState() => _BatchClassesState();
}

class _BatchClassesState extends State<BatchClasses> {
  List<List<dynamic>> _list = [];
  List<List<dynamic>> _filteredRows = [];
  bool isLoading = false;
  bool isSubmitted = false;
  int dataToShow = 20;

  TextEditingController searchController = TextEditingController();

  void saveBatchClasses() async {
    setState(() {
      isSubmitted = true;
    });

    try {
      List<Map<String, String>> classDataList = [];

      // Iterate through each row in _filteredRows
      for (var row in _filteredRows) {
        // Extract relevant data for each row
        String description = row[1]?.toString() ?? '';
        String subjectCode = row[0]?.toString() ?? '';
        String section = row[2]?.toString() ?? '';
        String room = row[7]?.toString() ?? ''; // Room

        String dayF2F = row[3]?.toString() ?? ''; // Day for face-to-face
        String startTimeF2F = ''; // Start time for face-to-face
        String endTimeF2F = ''; // End time for face-to-face
        String dayRC = row[5]?.toString() ?? ''; // Day for remote coaching
        String startTimeRC = ''; // Start time for remote coaching
        String endTimeRC = ''; // End time for remote coaching

        // Check if face-to-face start time is not null and split if valid
        if (row[4] != null && row[4].toString().contains('-')) {
          List<String> f2fTimes = row[4].toString().split('-');
          if (f2fTimes.length == 2) {
            startTimeF2F = f2fTimes[0];
            endTimeF2F = f2fTimes[1];
          }
        }

        // Check if remote coaching start time is not null and split if valid
        if (row[6] != null && row[6].toString().contains('-')) {
          List<String> rcTimes = row[6].toString().split('-');
          if (rcTimes.length == 2) {
            startTimeRC = rcTimes[0];
            endTimeRC = rcTimes[1];
          }
        }

        // Create a map for the current row's data
        Map<String, String> rowData = {
          "description": description.isNotEmpty ? description : '',
          "subjectCode": subjectCode.isNotEmpty ? subjectCode : '',
          "section": section.isNotEmpty ? section : '',
          "dayf2f": dayF2F.isNotEmpty ? dayF2F : '',
          "startTimef2f": startTimeF2F.isNotEmpty ? startTimeF2F : '',
          "endTimef2f": endTimeF2F.isNotEmpty ? endTimeF2F : '',
          "dayrc": dayRC.isNotEmpty ? dayRC : '',
          "startTimerc": startTimeRC.isNotEmpty ? startTimeRC : '',
          "endTimerc": endTimeRC.isNotEmpty ? endTimeRC : '',
          "room": room.isNotEmpty ? room : '',
        };

        // Add the row data to the list if any field is non-empty
        if (rowData.values.any((value) => value.isNotEmpty)) {
          classDataList.add(rowData);
        }
      }

      // print("json mo to be sent: ${jsonEncode(classDataList)}");

      // Prepare the request body
      Map<String, String> requestBody = {
        "json": jsonEncode(classDataList), // Encode the list of maps
        "operation":
            "addClassesBatch", // Assuming this operation is for adding classes
      };

      // Make the HTTP request
      var res = await http.post(
        Uri.parse("${SessionStorage.url}admin.php"),
        body: requestBody,
      );
      if (res.body == "1") {
        ShowAlert().showAlert("success", "Successfully added");

        // Clear filtered rows
        _filteredRows.clear();
      } else {
        ShowAlert().showAlert("danger", "Failed to add");
        print(res.body);
      }
    } catch (e) {
      ShowAlert().showAlert("danger", "Network error");
    } finally {
      setState(() {
        isSubmitted = false;
      });
    }
  }

  void batchClasses() async {
    setState(() {
      isLoading = true;
    });
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
        allowMultiple: false,
      );

      if (result != null) {
        final bytes = result.files.single.bytes;
        final excel = Excel.decodeBytes(bytes!);

        // Clear the existing data
        _list.clear();
        _filteredRows.clear();

        for (var table in excel.tables.keys) {
          for (var row in excel.tables[table]!.rows) {
            // Check if all cells in the row are null, empty, contain only spaces, or non-string data types
            bool isAllNull = row.every(
                (cell) => cell == null || cell.value.toString().trim().isEmpty);

            // If the row contains all null, empty, space-only, or non-string values, skip it
            if (!isAllNull) {
              _list.add(row.map((cell) => cell!.value).toList());
            }
          }
        }

        // Update _filteredRows
        _filteredRows = List.from(_list);
        setState(() {});
      }
      print(_filteredRows);
    } catch (e) {
      ShowAlert().showAlert("danger", "Network error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      ),
      body: isLoading
          ? const LoadingSpinner()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      batchClasses();
                    },
                    child: const Text("Batch Classes"),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: _filteredRows.isNotEmpty &&
                              _filteredRows.first.isNotEmpty
                          ? DataTable2(
                              columns: <DataColumn2>[
                                for (var column in _filteredRows.first)
                                  DataColumn2(label: Text(column.toString())),
                              ],
                              rows: <DataRow2>[
                                for (var i = 1;
                                    i < _filteredRows.length && i <= dataToShow;
                                    i++)
                                  if (_filteredRows[i]
                                      .any((cell) => cell != null))
                                    DataRow2(
                                      cells: <DataCell>[
                                        for (var j = 0;
                                            j < _filteredRows[i].length;
                                            j++)
                                          DataCell(
                                            Text(
                                              _filteredRows[i][j]?.toString() ??
                                                  '',
                                            ),
                                          ),
                                      ],
                                    ),
                              ],
                            )
                          : const Text('No data available'),
                    ),
                  ),
                ),
                _filteredRows.isNotEmpty && _filteredRows.first.isNotEmpty
                    ? const Expanded(
                        child: Text(
                          "and more",
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 24),
                _filteredRows.isNotEmpty && _filteredRows.first.isNotEmpty
                    ? isSubmitted
                        ? const LoadingSpinner()
                        : MyButton(
                            buttonText: "Submit",
                            buttonSize: 16,
                            color: Theme.of(context).colorScheme.tertiary,
                            onPressed: () {
                              saveBatchClasses();
                            },
                          )
                    : const SizedBox(),
              ],
            ),
    );
  }
}
