import 'package:flutter/material.dart';
import 'package:iiest_attendance/home_page/class_page.dart';

class TeacherClassTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.green.shade100,
                  offset: Offset(1.0, 5.0),
                  blurRadius: 10),
              //BoxShadow
            ],
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'DSA',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'IT 2101',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.grey),
                    ),
                  ],
                ),
                VerticalDivider(thickness: 2.0),
                // Column(
                //   children: [
                //     Text(
                //       '25',
                //       style: TextStyle(
                //           color: Colors.green,
                //           fontSize: 20,
                //           fontWeight: FontWeight.bold),
                //     ),
                //     SizedBox(
                //       height: 20,
                //     ),
                //     Text(
                //       'Total Classes',
                //       style: TextStyle(
                //           fontWeight: FontWeight.w500, color: Colors.grey),
                //     ),
                //   ],
                // ),
                // VerticalDivider(thickness: 2.0),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (f) => ClassHomePage(
                            class_name: 'DSA - IT2101', id: 'id')));
                  },
                  icon: Icon(Icons.arrow_forward, color: Colors.black),
                  label:
                      Text('View Class', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(primary: Colors.green[200]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
