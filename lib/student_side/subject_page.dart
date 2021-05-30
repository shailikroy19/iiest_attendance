import 'package:flutter/material.dart';
import 'package:iiest_attendance/colors.dart';
import 'package:iiest_attendance/widgets/student_subject_history_tile.dart';

class SubjectPage extends StatefulWidget {
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
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
                        "DSA - IT2101",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ],
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.history_edu_outlined, color: Colors.black),
                          Text('View History',
                              style: TextStyle(color: Colors.black)),
                        ],
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
          preferredSize: Size(MediaQuery.of(context).size.width, 102.0),
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
              SingleChildScrollView(
                child: Column(
                  children: [
                    StudentSubjectHistoryTile(isPresent: true),
                    StudentSubjectHistoryTile(isPresent: false),
                  ],
                ),
              ),
            ])
          ],
        ),
        bottomNavigationBar: iiestFooter(Colors.white),
      ),
    );
  }
}
