import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiest_attendance/colors.dart';
import 'package:iiest_attendance/widgets/student_classes_tile.dart';
import 'package:iiest_attendance/widgets/student_profile_modal_sheet.dart';

class StudentHomePage extends StatefulWidget {
  final user;
  const StudentHomePage({required this.user});
  @override
  _StudentHomePageState createState() => _StudentHomePageState(user: user);
}

class _StudentHomePageState extends State<StudentHomePage> {
  User user;
  _StudentHomePageState({required this.user});

  @override
  Widget build(BuildContext context) {
    //name and enrol
    String name, enrol, email;

    email = user.email.toString();

    enrol = email.substring(0, 9);

    name = "DEMO";

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
                    StudentModalSheet(context, size, name, enrol, email);
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
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffC9FFD9), Colors.white12],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft)),
          ),
          SingleChildScrollView(
            child: Container(
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [StudentClassTile()],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: iiestFooter(Colors.white),
    );
  }
}
