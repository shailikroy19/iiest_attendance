import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiest_attendance/colors.dart';
import 'package:iiest_attendance/student_side/qr_code_scanner.dart';
import 'package:iiest_attendance/widgets/student_subject_history_tile.dart';

class SubjectPage extends StatefulWidget {
  final String name, uid, sem;
  SubjectPage({required this.name, required this.uid, required this.sem});
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List attendance = [];

    dynamic fetchAttendance(String uid) {
      FirebaseFirestore.instance
          .collection("Teachers")
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          try {
            if (doc['$uid'] != null) {
              List attList = doc['$uid'];
              String? email = FirebaseAuth.instance.currentUser!.email;
              for (int i = attList.length - 1; i >= 0; i--) {
                if (attList[i]['email'] == email) {
                  attendance.add(attList[i]);
                }
              }
            }
          } catch (e) {
            //print(e);
          }
        });
      });
      return FirebaseFirestore.instance.collection("Teachers").get();
    }

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
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
                      padding:
                          EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
                      child: Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, bottom: 2.0),
                  child: Text(
                    "Sem: " + widget.sem + "\n" + "Class Code: " + widget.uid,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                TabBar(
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.add_box_outlined, color: Colors.black),
                          Text('Give Attendance',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    Tab(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {});
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.history_edu_outlined,
                                color: Colors.black),
                            Text('View History',
                                style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ],
                  indicatorColor: Colors.orange,
                  indicatorWeight: 3.0,
                ),
              ],
            ),
            decoration: BoxDecoration(
                gradient: iiestGradient,
                backgroundBlendMode: BlendMode.multiply),
          ),
          preferredSize: Size(MediaQuery.of(context).size.width, 140.0),
        ),
        body: TabBarView(
          children: [
            Stack(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 30, left: 20, right: 20),
                      child: Text(
                        "Scan QR Code from Teacher's Phone to give attendance.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //todo : add scanner
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) =>
                                    QRViewExample(uid: widget.uid)))
                            .then((value) {
                          setState(() {});
                        });
                      },
                      child: Text(
                        "Scan QR Code",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orange[200],
                          minimumSize: Size(120, 120)),
                    )
                  ],
                ),
              ],
            ),
            Stack(children: [
              Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xffC9FFD9), Colors.white12],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft)),
              ),
              FutureBuilder(
                future: fetchAttendance(widget.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(strokeWidth: 2.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text('Loading... Please Wait')),
                        ),
                      ],
                    );
                  }

                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        'An unexpexted error occured!',
                        style: TextStyle(color: Colors.red),
                      )),
                    );
                  }
                  if (attendance.length == 0) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        'No Attendance Records Found!',
                        style: TextStyle(color: Colors.red),
                      )),
                    );
                  }
                  return ListView.builder(
                    itemCount: attendance.length,
                    itemBuilder: (context, index) {
                      return StudentSubjectHistoryTile(
                          date: attendance[index]['date']);
                    },
                  );
                },
              ),
              // SingleChildScrollView(
              //   child: Column(
              //     children: [
              //       StudentSubjectHistoryTile(),
              //       StudentSubjectHistoryTile(),
              //     ],
              //   ),
              // ),
            ])
          ],
        ),
        bottomNavigationBar: iiestFooter(Colors.white),
      ),
    );
  }
}
