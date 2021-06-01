import 'package:flutter/material.dart';

class StudentListHistory extends StatelessWidget {
  final String email;
  StudentListHistory({required this.email});
  @override
  Widget build(BuildContext context) {
    bool ispresent = true;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              email.substring(0, 9),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            VerticalDivider(
              thickness: 1.5,
              color: Colors.black,
            ),
            Text(
              email
                  .substring(email.indexOf('.') + 1, email.indexOf('@'))
                  .toUpperCase(),
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
