import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiest_attendance/home_page/student_home.dart';
import 'package:iiest_attendance/home_page/teacher_home.dart';

class HomeScreen extends StatefulWidget {
  final user;
  const HomeScreen({required this.user});
  @override
  _HomeScreenState createState() => _HomeScreenState(user: user);
}

class _HomeScreenState extends State<HomeScreen> {
  User user;
  _HomeScreenState({required this.user});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 800), () {
      String email = user.email.toString();
      if (email.endsWith('students.iiests.ac.in')) {
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (f) => StudentHomePage(user: user)));
      } else {
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (f) => TeacherHomePage(user: user)));
      }
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(strokeWidth: 2.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('Signing In... Please Wait')),
          ),
        ],
      ),
    );
  }
}
