import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheet/Provider/getYear.dart';
import 'DataScreen.dart';

class MonthScreen extends StatelessWidget {
  static String id = 'month_screen';
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  Map<String, String> m1 = {
    'January': '1',
    'February': '2',
    'March': '3',
    'April': '4',
    'May': '5',
    'June': '6',
    'July': '7',
    'August': '8',
    'September': '9',
    'October': '10',
    'November': '11',
    'December': '12'
  };
  @override
  Widget build(BuildContext context) {
    return Consumer<getTheTimeOfWorkShobmitted>(builder: (BuildContext context,
        getTheTimeOfWorkShobmitted value, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Select Month'),
        ),
        body: ListView.builder(
            itemCount: months.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                    title: Text(months[index]),
                    onTap: () {
                      value.setMonth(m1[months[index]] ?? 'no');
                      // String docname = value.getYandM();
                      Navigator.pushNamed(context, Datascreen.id);
                    }),
              );
            }),
      );
    });
  }
}
