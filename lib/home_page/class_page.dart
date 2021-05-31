import 'package:flutter/material.dart';
import 'package:iiest_attendance/colors.dart';
import 'package:iiest_attendance/teachers_side/generate_qr.dart';
import 'package:iiest_attendance/teachers_side/teacher_subject_page.dart';

class ClassHomePage extends StatefulWidget {
  final String class_name, id;

  const ClassHomePage({required this.class_name, required this.id});
  @override
  _ClassHomePageState createState() => _ClassHomePageState();
}

class _ClassHomePageState extends State<ClassHomePage> {
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
                    Tooltip(
                      message: 'Delete Class',
                      child: InkWell(
                        child: IconButton(
                          onPressed: () {
                            //TODO: Delete
                          },
                          icon: Icon(
                            Icons.delete_outline,
                            size: 28.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
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
          preferredSize: Size(MediaQuery.of(context).size.width, 120.0),
        ),
        body: TabBarView(
          children: [
            Center(
              child: ElevatedButton.icon(
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
            ),
            //Icon(Icons.directions_transit),
            TeacherSubject(),
          ],
        ),
        bottomNavigationBar: iiestFooter(Colors.white),
      ),
    );
  }
}
