import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';

class Datalist extends StatefulWidget {
  const Datalist({super.key});

  @override
  State<Datalist> createState() => _DatalistState();
}

class _DatalistState extends State<Datalist> {
  @override
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> l1 =
        Provider.of<List<Map<String, dynamic>>>(context);

    // Get the list of columns from the first map's keys
    List<String> columns = l1.isNotEmpty ? l1.first.keys.toList() : [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Data List'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              String? path = await _pickSavePath('csv');
              if (path != null) {
                _exportToCSV(columns, l1, path);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.save_alt),
            onPressed: () async {
              String? path = await _pickSavePath('xlsx');
              if (path != null) {
                _exportToExcel(columns, l1, path);
              }
            },
          ),
        ],
      ),
      body: l1.isEmpty
          ? Center(child: Text('No data available'))
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  columns: columns
                      .map((column) => DataColumn(
                            label: Text(
                              column,
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ))
                      .toList(),
                  rows: l1.map((row) {
                    return DataRow(
                      cells: columns.map((column) {
                        return DataCell(
                          Text(row[column].toString()),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
              ),
            ),
    );
  }

  Future<String?> _pickSavePath(String extension) async {
    FilePickerResult? result = (await FilePicker.platform.saveFile(
      dialogTitle: 'Please select a path:',
      fileName: 'data.$extension',
    )) as FilePickerResult?;
    return result != null ? result.files.single.path : null;
  }

  void _exportToCSV(List<String> columns, List<Map<String, dynamic>> data,
      String path) async {
    List<List<String>> csvData = [
      columns, // Header row
      ...data.map((row) => columns.map((col) => row[col].toString()).toList())
    ];

    String csv = const ListToCsvConverter().convert(csvData);

    final file = File(path);
    await file.writeAsString(csv);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('CSV file saved to $path')),
    );
  }

  void _exportToExcel(List<String> columns, List<Map<String, dynamic>> data,
      String path) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    // Add header row
    sheetObject.appendRow(columns);

    // Add data rows
    for (var row in data) {
      sheetObject.appendRow(columns.map((col) => row[col].toString()).toList());
    }

    final file = File(path);
    await file.writeAsBytes(excel.encode()!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Excel file saved to $path')),
    );
  }
}
