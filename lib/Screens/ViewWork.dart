import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheet/Provider/getYear.dart';
import 'package:sheet/Screens/MonthScreen.dart';

class ViewWork extends StatelessWidget {
  List<String> years = ['2023', '2024', '2025', '2026', '2027'];
  static String id = 'ViewWork';
  @override
  Widget build(BuildContext context) {
    return Consumer<getTheTimeOfWorkShobmitted>(builder: (BuildContext context,
        getTheTimeOfWorkShobmitted value, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Select Year'),
        ),
        body: ListView.builder(
          itemCount: years.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(years[index]),
                onTap: () {
                  value.setYear(years[index]);
                  Navigator.pushNamed(
                    context,
                    MonthScreen.id,
                  );
                },
              ),
            );
          },
        ),
      );
    });
  }
}
