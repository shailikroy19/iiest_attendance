import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiest_attendance/colors.dart';
import 'package:iiest_attendance/student_side/join_class_page.dart';
import 'package:iiest_attendance/student_side/subject_page.dart';
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

    var data;

    bool isEmpty = false;

    String name, enrol, email;

    List classListStudent = [];

    email = user.email.toString();

    enrol = email.substring(0, 9);

    name = "";

    final size = MediaQuery.of(context).size;

    return FutureBuilder<DocumentSnapshot>(
      future:
          FirebaseFirestore.instance.collection('Students').doc(email).get(),
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
          classListStudent = data['classes'];
          if (classListStudent.length == 0) {
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
                                context, size, name, enrol, email);
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
              (isEmpty)
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No classes joined yet.',
                            style: TextStyle(color: Colors.red, fontSize: 20.0),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Join a class using the code provided to you by your teacher.',
                            style:
                                TextStyle(color: Colors.black, fontSize: 12.0),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: classListStudent.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: StudentClassTile(
                            subjName: classListStudent[index]['subj_name'],
                            subjCode: classListStudent[index]['subj_code'],
                            sem: classListStudent[index]['sem'],
                            uid: classListStudent[index]['uid'],
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SubjectPage(
                                  name: classListStudent[index]['subj_name'] +
                                      " - " +
                                      classListStudent[index]['subj_code'],
                                  sem: classListStudent[index]['sem'],
                                  uid: classListStudent[index]['uid'],
                                ),
                              ),
                            );
                          },
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
                          JoinClass(classList: classListStudent, email: email)))
                  .then((value) {
                setState(() {});
              });
            },
            icon: Icon(Icons.add, color: Colors.black),
            label: Text('Join a Class', style: TextStyle(color: Colors.black)),
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
