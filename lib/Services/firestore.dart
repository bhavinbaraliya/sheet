import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final String user;
  final CollectionReference db;

  Database({required this.user})
      : db = FirebaseFirestore.instance.collection(user);

  Future<void> update(
      String activity,
      String tag,
      String rev,
      String client,
      String proj,
      String job,
      String time,
      String prEngr,
      String remark,
      int month,
      int year,
      String date) async {
    print('1');
    String docName = '${month}';
    DocumentReference docRef = db.doc(docName);
    Map<String, dynamic> newRecord = {
      'Activity': activity,
      'Tag': tag,
      'Rev': rev,
      'Client': client,
      'Project': proj,
      'Job': job,
      'PrE': prEngr,
      'remark': remark,
      'date': date,
    };

    try {
      print('2');
      DocumentSnapshot docSnap = await docRef.get();
      print('3');
      if (docSnap.exists) {
        print('4');
        List<dynamic> records = docSnap.get('records') ?? [];
        records.add(newRecord);
        await docRef.update({'records': records});
        print('5');
        print('Update success!');
      } else {
        print('6');
        await docRef.set({
          'records': [newRecord]
        });
        print('7');
        print('Document created and updated successfully!');
      }
    } catch (e) {
      print('8');
      print('Error updating document: $e');
    }
  }
}
