import 'package:flutter/material.dart';
import 'package:iiest_attendance/colors.dart';
import 'package:iiest_attendance/widgets/student_list_in_attendance_history.dart';

class AttendanceHistory extends StatefulWidget {
  final String date;
  final List students;
  AttendanceHistory({required this.date, required this.students});
  @override
  _AttendanceHistoryState createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory> {
  @override
  Widget build(BuildContext context) {
    List abc = [];
    for (int i = 0; i < widget.students.length; i++) {
      if (widget.students[i]['date'] == widget.date) {
        abc.add(widget.students[i]['email']);
      }
    }
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          //height: 120,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Date: ${widget.date}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "No. of Students Present: ${abc.length}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: BoxDecoration(gradient: iiestGradient),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 67.0),
      ),
      body: ListView.builder(
        itemCount: abc.length,
        itemBuilder: (context, index) {
          return StudentListHistory(email: abc[index]);
        },
      ),
    );
  }
}
