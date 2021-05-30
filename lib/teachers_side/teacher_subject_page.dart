import 'package:flutter/material.dart';
import 'package:iiest_attendance/colors.dart';
import 'package:iiest_attendance/teachers_side/attendance_history_page.dart';

class TeacherSubject extends StatefulWidget {
  @override
  _TeacherSubjectState createState() => _TeacherSubjectState();
}

class _TeacherSubjectState extends State<TeacherSubject> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            tileColor: Colors.orange[200],
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (f) => AttendanceHistory()));
            },
            title: Text(
              '29.05.2021',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            //TODO: Present&time
            trailing: Text('Present: 32'),
            subtitle: Text('14:32'),
          ),
        ),
      ],
    );
  }
}
