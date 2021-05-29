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
          padding: const EdgeInsets.all(30.0),
          child: FlatButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (f) => AttendanceHistory()));
            },
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.teal[200],
                boxShadow: [
                  BoxShadow(
                      color: Colors.green.shade100,
                      offset: Offset(1.0, 5.0),
                      blurRadius: 10),
                  //BoxShadow
                ],
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Center(
                child: Text(
                  '29.05.2021',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
