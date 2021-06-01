import 'package:flutter/material.dart';

class StudentSubjectHistoryTile extends StatelessWidget {
  final String date;
  StudentSubjectHistoryTile({required this.date});
  @override
  Widget build(BuildContext context) {
    bool isPresent = true;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.orange[100],
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(1.0, 1.0),
                blurRadius: 5,
              ),
              //BoxShadow
            ],
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: ListTile(
          title: Text(
            date,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          trailing: Text(
            (isPresent) ? 'Present' : 'Absent',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: (isPresent) ? Colors.green : Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
