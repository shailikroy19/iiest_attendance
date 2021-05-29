import 'package:flutter/material.dart';
import 'package:iiest_attendance/login_page/first_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IIEST Attendance Portal',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: FirstScreen(),
    );
  }
}
