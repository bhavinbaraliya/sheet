import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Services/firestore.dart' as firestore;
import '../Services/MonthYear.dart';

class ViewWork extends StatefulWidget {
  static String id = 'ViewWork';

  @override
  _ViewWorkState createState() => _ViewWorkState();
}

class _ViewWorkState extends State<ViewWork> {
  final db = firestore.Database(user: 'dummy');
  List<List<Map<String, dynamic>>> works = [];
  Map<String, List<Map<String, dynamic>>> worksByMonthYear = {};

  @override
  void initState() {
    super.initState();
    fetchWorks();
  }

  Future<void> fetchWorks() async {
    groupWorksByMonthYear();
    setState(() {});
  }

  void groupWorksByMonthYear() {
    worksByMonthYear = {};
    for (var w1 in works) {
      for (var work in w1) {
        final monthYear = '${work['month']}/${work['year']}';
        if (worksByMonthYear.containsKey(monthYear)) {
          worksByMonthYear[monthYear]!.add(work);
        } else {
          worksByMonthYear[monthYear] = [work];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Work'),
      ),
      body: worksByMonthYear.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: worksByMonthYear.length,
              itemBuilder: (context, index) {
                final monthYear = worksByMonthYear.keys.toList()[index];
                final works = worksByMonthYear[monthYear]!;
                return MonthYearWidget(monthYear: monthYear, works: works);
              },
            ),
    );
  }
}
