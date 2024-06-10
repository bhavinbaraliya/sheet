import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedWorkScreen extends StatelessWidget {
  final String month;
  final int year;

  DetailedWorkScreen({required this.month, required this.year});

  @override
  Widget build(BuildContext context) {
    // Fetch and display work associated with the selected month-year combination
    return Scaffold(
      appBar: AppBar(
        title: Text('$month $year Work'),
      ),
      body: Center(
        child: Container(),
      ),
    );
  }
}
