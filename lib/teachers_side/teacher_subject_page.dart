import 'package:flutter/material.dart';
import 'package:iiest_attendance/teachers_side/attendance_history_page.dart';

class TeacherSubject extends StatefulWidget {
  final String date;
  final List students;
  TeacherSubject({required this.date, required this.students});
  @override
  _TeacherSubjectState createState() => _TeacherSubjectState();
}

class _TeacherSubjectState extends State<TeacherSubject> {
  @override
  Widget build(BuildContext context) {
    final String date = widget.date;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            tileColor: Colors.orange[200],
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (f) => AttendanceHistory(
                      date: date, students: widget.students)));
            },
            title: Text(
              date,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text('Tap to view details'),
          ),
        ),
      ],
    );
  }
}
