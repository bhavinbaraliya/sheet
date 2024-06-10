import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MonthYearWidget extends StatelessWidget {
  final String monthYear;
  final List<Map<String, dynamic>> works;

  MonthYearWidget({required this.monthYear, required this.works});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(monthYear),
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: works.length,
          itemBuilder: (context, index) {
            final work = works[index];
            return ListTile(
              title: Text(work['activity'] ?? ''),
              subtitle: Text('${work['date']} | ${work['time']} hrs'),
              // Add any other details you want to display in the ListTile
            );
          },
        ),
      ],
    );
  }
}
