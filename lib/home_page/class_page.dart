import 'package:flutter/material.dart';
import 'package:iiest_attendance/colors.dart';
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
                      child: Text(
                        widget.class_name,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
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
          preferredSize: Size(MediaQuery.of(context).size.width, 102.0),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.directions_car),
            //Icon(Icons.directions_transit),
            TeacherSubject(),
          ],
        ),
        bottomNavigationBar: iiestFooter(Colors.white),
      ),
    );
  }
}
