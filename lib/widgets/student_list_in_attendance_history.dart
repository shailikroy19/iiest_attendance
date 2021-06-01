import 'package:flutter/material.dart';

class StudentListHistory extends StatelessWidget {
  //TODO:have to make it as user input
  final String enroll = "510819019";
  final String name = "Aniket Majhi";

  @override
  Widget build(BuildContext context) {
    bool ispresent = true;
    return ListTile(
      title: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "$enroll",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            VerticalDivider(
              thickness: 1.5,
              color: Colors.black,
            ),
            Text(
              "$name",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            VerticalDivider(
              thickness: 1.5,
              color: Colors.black,
            ),
            Text(
              (ispresent == true) ? 'Present' : 'Absent ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: (ispresent) ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
