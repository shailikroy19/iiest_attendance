import 'package:flutter/material.dart';
import 'package:iiest_attendance/colors.dart';
import 'package:iiest_attendance/widgets/student_classes_tile.dart';
import 'package:iiest_attendance/widgets/student_profile_modal_sheet.dart';

class StudentHomePage extends StatefulWidget {
  final String name, enrol, email;
  const StudentHomePage(
      {required this.name, required this.enrol, required this.email});
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
                child: Text(
                  'Attendance Portal',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              Tooltip(
                message: 'View Profile',
                child: IconButton(
                  onPressed: () {
                    StudentModalSheet(
                        context, size, widget.name, widget.enrol, widget.email);
                  },
                  icon: Icon(
                    Icons.account_circle_outlined,
                    size: 28.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              gradient: iiestGradient, backgroundBlendMode: BlendMode.multiply),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 55.0),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [StudentClassTile()],
          ),
        ),
      ),
    );
  }
}
