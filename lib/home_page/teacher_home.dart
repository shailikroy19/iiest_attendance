import 'package:cloud_firestore/cloud_firestore.dart';
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

    bool isEmpty = false;

    email = user.email.toString();
    name = "";
    var data;

    List classesList = [];

    final size = MediaQuery.of(context).size;

    return FutureBuilder<DocumentSnapshot>(
      future:
          FirebaseFirestore.instance.collection('Teachers').doc(email).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(strokeWidth: 2.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text('Loading... Please Wait')),
                ),
              ],
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                'An unexpexted error occured!',
                style: TextStyle(color: Colors.red),
              )),
            ),
          );
        }
        if (snapshot.hasData) {
          data = snapshot.data?.data();
          name = data['name'];
          classesList = data['classes'];
          if (classesList.length == 0) {
            isEmpty = true;
          }
        }
        return Scaffold(
          appBar: PreferredSize(
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, top: 15.0, bottom: 15.0),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14.0, 8.0, 8.0, 8.0),
                    child: Text(
                      'Welcome: ${name}',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  gradient: iiestGradient,
                  backgroundBlendMode: BlendMode.multiply),
            ),
            preferredSize: Size(MediaQuery.of(context).size.width, 85.0),
          ),
          body: (isEmpty)
              ? Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No classes created yet.',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Create a class to take attendance.',
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                        ),
                      ],
                    ),
                  ),
                )
              : Stack(
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
                    ListView.builder(
                      itemCount: classesList.length,
                      itemBuilder: (context, index) {
                        return TeacherClassTile(
                          subjName: classesList[index]['subj_name'],
                          subjCode: classesList[index]['subj_code'],
                          sem: classesList[index]['sem'],
                          uid: classesList[index]['uid'],
                          email: email,
                        );
                      },
                    ),
                  ],
                ),
          floatingActionButton: ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (f) =>
                          CreateClass(email: email, classesList: classesList)))
                  .then((value) {
                setState(() {});
              });
            },
            icon: Icon(Icons.add, color: Colors.black),
            label:
                Text('Create a Class', style: TextStyle(color: Colors.black)),
            style: ElevatedButton.styleFrom(
                primary: Colors.orange[200],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          bottomNavigationBar: iiestFooter(Colors.white),
        );
      },
    );
  }
}
