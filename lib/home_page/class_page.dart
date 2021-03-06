import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iiest_attendance/colors.dart';
import 'package:iiest_attendance/teachers_side/generate_qr.dart';
import 'package:iiest_attendance/teachers_side/teacher_subject_page.dart';

class ClassHomePage extends StatefulWidget {
  final String class_name, id, email, uid;

  const ClassHomePage(
      {required this.class_name,
      required this.id,
      required this.email,
      required this.uid});
  @override
  _ClassHomePageState createState() => _ClassHomePageState();
}

class _ClassHomePageState extends State<ClassHomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final email = widget.email;
    final uid = widget.uid;
    List attendanceList = [];
    var data;
    bool isEmpty = false;
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
                          EdgeInsets.only(left: 15.0, top: 15.0, bottom: 10.0),
                      child: Column(
                        children: [
                          Text(
                            widget.class_name,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    // Tooltip(
                    //   message: 'Delete Class',
                    //   child: InkWell(
                    //     child: IconButton(
                    //       onPressed: () {
                    //         //TODO: Delete
                    //       },
                    //       icon: Icon(
                    //         Icons.delete_outline,
                    //         size: 28.0,
                    //         color: Colors.black,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, bottom: 5.0),
                  child: SelectableText(
                    "Class Code: " + widget.id,
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
                          Text('Take Attendance',
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
          preferredSize: Size(MediaQuery.of(context).size.width, 120.0),
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
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Tap to show QR Code.',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (f) => GenerateQRCode(uid: widget.id)));
                        },
                        icon: Icon(Icons.add_outlined, color: Colors.black),
                        label: Text('Take Attendance',
                            style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange[200],
                          fixedSize: Size(size.width / 2, 100.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Students need to scan the code on their phones.',
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'On scanning, attendance is registered automatically.',
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //Icon(Icons.directions_transit),
            //TeacherSubject(),
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('Teachers')
                  .doc(email)
                  .get(),
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
                      child: Text('An unexpexted error occured!'),
                    ),
                  );
                }

                if (snapshot.hasData) {
                  data = snapshot.data?.data();

                  attendanceList = data[uid];
                  if (attendanceList.length == 0) {
                    isEmpty = true;
                  }
                }

                List abc = List.generate(attendanceList.length,
                    (index) => attendanceList[index]['date']);

                //REMOVE DUPLICATE ENTRIES//REMOVE DUPLICATE ENTRIES//REMOVE DUPLICATE ENTRIES
                abc = [
                  ...{...abc}
                ];
                //REMOVE DUPLICATE ENTRIES//REMOVE DUPLICATE ENTRIES//REMOVE DUPLICATE ENTRIES

                return isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No attendance records found for this class.',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: abc.length,
                        itemBuilder: (context, index) {
                          return TeacherSubject(
                            date: abc[index],
                            students: attendanceList,
                          );
                        },
                      );
              },
            ),
          ],
        ),
        bottomNavigationBar: iiestFooter(Colors.white),
      ),
    );
  }
}
