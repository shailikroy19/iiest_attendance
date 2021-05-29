import 'package:flutter/material.dart';

class StudentSubjectHistoryTile extends StatelessWidget {
  final bool isPresent = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
            color: isPresent ? Colors.green.shade100 : Colors.red.shade100,
            boxShadow: [
              BoxShadow(
                  color:
                      isPresent ? Colors.green.shade100 : Colors.red.shade100,
                  offset: Offset(1.0, 5.0),
                  blurRadius: 10),
              //BoxShadow
            ],
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date : 24/04/2021"),
                isPresent ? Text("Present") : Text("Absent"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
