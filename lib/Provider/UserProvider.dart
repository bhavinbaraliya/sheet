import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class getName extends ChangeNotifier {
  String uid = '';
  void getname(String uid) {
    this.uid = uid;
    print(this.uid);
    notifyListeners();
  }
}
