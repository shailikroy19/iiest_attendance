import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iiest_attendance/colors.dart';
import 'package:iiest_attendance/widgets/student_list_in_attendance_history.dart';

class AttendanceHistory extends StatefulWidget {
  @override
  _AttendanceHistoryState createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          //height: 120,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Student\'s List',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),

                //TODO: total students
                Text(
                  "Total no. of Students: 99",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: BoxDecoration(gradient: iiestGradient),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 65.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StudentListHistory(ispresent: true),
            StudentListHistory(ispresent: false),
          ],
        ),
      ),
    );
  }
}
