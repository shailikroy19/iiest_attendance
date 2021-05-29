import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiest_attendance/colors.dart';
import 'package:iiest_attendance/teachers_side/create_class_page.dart';
import 'package:iiest_attendance/widgets/teacher_class_tile.dart';
import 'package:iiest_attendance/widgets/teacher_profile_modal_sheet.dart';

class TeacherHomePage extends StatefulWidget {
  final User user;
  const TeacherHomePage({required this.user});
  @override
  _TeacherHomePageState createState() => _TeacherHomePageState(user: user);
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  User user;
  _TeacherHomePageState({required this.user});

  @override
  Widget build(BuildContext context) {
    String name, email;

    email = user.email.toString();
    name = "DEMO";

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
                    child: Text(
                      'Teacher\'s Corner',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                  Tooltip(
                    message: 'View Profile',
                    child: InkWell(
                      child: IconButton(
                        onPressed: () {
                          TeacherModalSheet(context, size, name, email);
                        },
                        icon: Icon(
                          Icons.account_circle_outlined,
                          size: 28.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
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
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (f) => CreateClass()));
                    },
                    icon: Icon(Icons.add, color: Colors.black),
                    label: Text('Create a Class',
                        style: TextStyle(color: Colors.black)),
                    style:
                        ElevatedButton.styleFrom(primary: Colors.orange[200]),
                  ),
                  TeacherClassTile(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: iiestFooter(Colors.white),
    );
  }
}
