import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iiest_attendance/home_page/home_screen.dart';
import 'package:iiest_attendance/login_page/first_screen.dart';

void main() async {
  //initialize the app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //run the app
  //

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return HomeScreen(user: snapshot.data);
          }
          return FirstScreen();
        },
      ),
    );
  }
}


// ????????????????????????????????????????????????????????????????????????????????
// teacher.dummy@gmail.com
// Password: 12345678


// ????????????????????????????????????????????????????????????????????????????????
// 510819011.shailik@students.iiests.ac.in
// Password: 19042001