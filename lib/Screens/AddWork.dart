import 'package:flutter/material.dart';
import 'package:googleapis/securitycenter/v1.dart' as googleapis;
import 'package:provider/provider.dart';
import '../Provider/UserProvider.dart';
import '../Services/firestore.dart' as firestore;
import 'ViewWork.dart';

class AddWork extends StatefulWidget {
  static String id = 'AddWork';

  @override
  _AddWorkState createState() => _AddWorkState();
}

class _AddWorkState extends State<AddWork> {
  TextEditingController _activityController = TextEditingController();
  TextEditingController _tagNoController = TextEditingController();
  TextEditingController _revController = TextEditingController();
  TextEditingController _clientController = TextEditingController();
  TextEditingController _projectController = TextEditingController();
  TextEditingController _jobNoController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _prEngrController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Consumer<getName>(
        builder: (BuildContext context, value, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('User Input Page'),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width *
                0.5, // 50% of the screen width
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Day:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Text(
                              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    _buildInputRow('Activity:', _activityController),
                    const SizedBox(height: 16.0),
                    _buildInputRow('Tag No.:', _tagNoController),
                    const SizedBox(height: 16.0),
                    _buildInputRow('Rev.:', _revController),
                    const SizedBox(height: 16.0),
                    _buildInputRow('Client:', _clientController),
                    const SizedBox(height: 16.0),
                    _buildInputRow('Project:', _projectController),
                    const SizedBox(height: 16.0),
                    _buildInputRow('Job No.:', _jobNoController),
                    const SizedBox(height: 16.0),
                    _buildInputRow('Time (Hrs):', _timeController),
                    const SizedBox(height: 16.0),
                    _buildInputRow('Pr. Engr.:', _prEngrController),
                    const SizedBox(height: 16.0),
                    _buildInputRow('Remark:', _remarkController),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              final db = firestore.Database(user: value.uid);
                              String activity = _activityController.text;
                              String tagNo = _tagNoController.text;
                              String rev = _revController.text;
                              String client = _clientController.text;
                              String project = _projectController.text;
                              String jobNo = _jobNoController.text;
                              String time = _timeController.text;
                              String prEngr = _prEngrController.text;
                              String remark = _remarkController.text;
                              String date =
                                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}';

                              await db.update(
                                activity,
                                tagNo,
                                rev,
                                client,
                                project,
                                jobNo,
                                time,
                                prEngr,
                                remark,
                                _selectedDate.month,
                                _selectedDate.year,
                                date,
                              );

                              _activityController.clear();
                              _tagNoController.clear();
                              _revController.clear();
                              _clientController.clear();
                              _projectController.clear();
                              _jobNoController.clear();
                              _timeController.clear();
                              _prEngrController.clear();
                              _remarkController.clear();

                              print('Activity: $activity');
                              print('Tag No.: $tagNo');
                              print('Rev.: $rev');
                              print('Client: $client');
                              print('Project: $project');
                              print('Job No.: $jobNo');
                              print('Time (Hrs): $time');
                              print('Pr. Engr.: $prEngr');
                              print('Remark: $remark');
                              print('Date: $date');
                            } catch (e) {
                              print('Error: $e');
                            }
                          },
                          child: Text('Submit'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, ViewWork.id);
                          },
                          child: Text('View Work'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildInputRow(String label, TextEditingController controller) {
    return Row(
      children: [
        Container(
          width: 100, // Set a fixed width for the labels
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
