import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> _list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              /// Use FilePicker to pick files in Flutter Web
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['xlsx'],
                allowMultiple: false,
              );

              if (result != null) {
                final bytes = result.files.single.bytes;
                final excel = Excel.decodeBytes(bytes!);
                //iterate thru all sheets
                for (var table in excel.tables.keys) {
                  // print(table); //sheet Name
                  // print(excel.tables[table]!.maxColumns);
                  // print(excel.tables[table]!.maxRows);
                  for (var row in excel.tables[table]!.rows) {
                    _list.add(
                        row.map((cell) => cell!.value.toString()).toList());
                  }

                  // or explicitly state the name of the sheet
                  // for (var row in excel.tables['Sheet1']!.rows) {
                  //   _list.add(row.map((cell) => cell!.value.toString()).toList());
                  // }

                  //process records here
                  print(_list);
                }
              }
            },
            child: Text("Open Excel"),
          ),
        ],
      ),
    );
  }
}

// masterfiles slideable

  // Widget masterFilesList() {
  //   if (masterFiles.isEmpty) {
  //     return const Center(
  //       child: Text(
  //         "No data found",
  //         style: TextStyle(
  //           color: Colors.white,
  //         ),
  //       ),
  //     );
  //   } else {
  //     return ListView.builder(
  //       itemCount: masterFiles.length,
  //       shrinkWrap: true,
  //       itemBuilder: (context, index) {
  //         bool isAdminList = _title == "Administrators";
  //         bool isSchoolYearList = _title == "School Year";
  //         bool isCurrentUser = masterFiles[index]["adm_employee_id"] == _userId;
  //         return Padding(
  //           padding: const EdgeInsets.only(bottom: 8.0),
  //           child: Slidable(
  //             startActionPane: isAdminList
  //                 ? ActionPane(motion: const BehindMotion(), children: [
  //                     SlidableAction(
  //                       onPressed: (context) {},
  //                       backgroundColor: const Color(0xFFFE4A49),
  //                       label: isCurrentUser
  //                           ? "You cant change your personal details here"
  //                           : "You cant change his/her personal details",
  //                     )
  //                   ])
  //                 : ActionPane(
  //                     motion: const BehindMotion(),
  //                     children: [
  //                       !isSchoolYearList
  //                           ? SlidableAction(
  //                               onPressed: (context) {
  //                                 // delete mo to
  //                               },
  //                               backgroundColor: const Color(0xFFFE4A49),
  //                               foregroundColor: Colors.white,
  //                               icon: Icons.delete,
  //                               label: 'Delete',
  //                             )
  //                           : SlidableAction(
  //                               onPressed: (context) {
  //                                 if (masterFiles[index]["sy_status"] == 1) {
  //                                   ShowAlert()
  //                                       .showAlert("info", "Already Active");
  //                                 } else {
  //                                   _handleSetActive(
  //                                       masterFiles[index]["sy_id"],
  //                                       masterFiles[index]["sy_name"]);
  //                                 }
  //                               },
  //                               backgroundColor: Theme.of(context)
  //                                   .colorScheme
  //                                   .onPrimaryContainer,
  //                               foregroundColor: Colors.white,
  //                               icon: masterFiles[index]["sy_status"] == 1
  //                                   ? Icons.check_circle_outline
  //                                   : Icons.check_outlined,
  //                               label: masterFiles[index]["sy_status"] == 1
  //                                   ? 'Already Active'
  //                                   : 'Set active',
  //                             ),
  //                       SlidableAction(
  //                         onPressed: (context) {
  //                           _handleUpdateMasterfiles(_title, _masterfileId);
  //                           print(masterFiles[index]["adm_id"]);
  //                         },
  //                         backgroundColor:
  //                             Theme.of(context).colorScheme.onInverseSurface,
  //                         icon: Icons.update,
  //                         label: 'Update',
  //                       ),
  //                     ],
  //                   ),
  //             child: Container(
  //               color: Theme.of(context).colorScheme.tertiary,
  //               padding: const EdgeInsets.all(8),
  //               child: ListTile(
  //                 title: Text(
  //                   '${masterFiles[index][_masterFileName]} ${masterFiles[index]['sy_status'] == 1 ? "(Currently Active)" : ""}',
  //                   style: const TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   }
  // }
