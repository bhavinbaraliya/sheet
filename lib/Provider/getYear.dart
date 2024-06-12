import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class getTheTimeOfWorkShobmitted extends ChangeNotifier {
  String year = '';
  String month = '';
  String getYandM() {
    return '${month},${year}';
  }

  void setYear(String year) {
    this.year = year;
    notifyListeners();
  }

  void setMonth(String month) {
    this.month = month;
    notifyListeners();
  }
}
