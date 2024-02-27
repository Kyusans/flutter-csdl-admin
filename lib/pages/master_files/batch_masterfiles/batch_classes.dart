import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:data_table_2/data_table_2.dart';

class BatchClasses extends StatefulWidget {
  const BatchClasses({Key? key}) : super(key: key);

  @override
  _BatchClassesState createState() => _BatchClassesState();
}

class _BatchClassesState extends State<BatchClasses> {
  List<List<dynamic>> _list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['xlsx'],
                allowMultiple: false,
              );

              if (result != null) {
                final bytes = result.files.single.bytes;
                final excel = Excel.decodeBytes(bytes!);
                for (var table in excel.tables.keys) {
                  for (var row in excel.tables[table]!.rows) {
                    _list.add(row.map((cell) => cell!.value).toList());
                  }
                }
                setState(() {}); // Trigger rebuild with new data
              }
            },
            child: const Text("Batch Classes"),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _list.isNotEmpty && _list.first.isNotEmpty
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: DataTable2(
                        columns: <DataColumn2>[
                          for (var column in _list.first)
                            DataColumn2(label: Text(column.toString())),
                        ],
                        rows: <DataRow2>[
                          for (var i = 1; i < _list.length; i++)
                            DataRow2(
                              cells: <DataCell>[
                                for (var j = 0; j < _list[i].length; j++)
                                  DataCell(Text(_list[i][j].toString())),
                              ],
                            ),
                        ],
                      ),
                    )
                  : Text('No data available'),
            ),
          ),
        ],
      ),
    );
  }
}
