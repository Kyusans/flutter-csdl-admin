import 'dart:io';
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
