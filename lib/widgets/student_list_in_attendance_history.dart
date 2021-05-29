import 'package:flutter/material.dart';

class StudentListHistory extends StatelessWidget {
  //TODO:have to make it as user input
  final String enroll = "510819019";
  final String name = "Aniket Majhi";
  final bool ispresent = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.teal[200],
            boxShadow: [
              BoxShadow(
                  color: Colors.green.shade100,
                  offset: Offset(1.0, 5.0),
                  blurRadius: 10),
              //BoxShadow
            ],
            borderRadius: BorderRadius.all(Radius.circular(7.0))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$enroll",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                VerticalDivider(
                  thickness: 2.0,
                  color: Colors.black,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$name",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                VerticalDivider(
                  thickness: 2.0,
                  color: Colors.black,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (ispresent == true) ? 'Present' : 'Absent',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
