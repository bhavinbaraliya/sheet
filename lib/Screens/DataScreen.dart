import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheet/Provider/getYear.dart';
import '../Provider/UserProvider.dart';
import '../Services/firestore.dart';
import 'Datalist.dart';

class Datascreen extends StatefulWidget {
  static String id = 'data_screen';

  @override
  State<Datascreen> createState() => _DatascreenState();
}

class _DatascreenState extends State<Datascreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<getTheTimeOfWorkShobmitted>(
      builder: (BuildContext context, val1, Widget? child) {
        return Consumer<getName>(
          builder: (BuildContext context, getName val2, Widget? child) {
            return StreamProvider<List<Map<String, dynamic>>>.value(
              initialData: [],
              value: Database(user: val2.uid).func(val1.getYandM()),
              child: Scaffold(
                body: Datalist(),
              ),
            );
          },
        );
      },
    );
  }
}
