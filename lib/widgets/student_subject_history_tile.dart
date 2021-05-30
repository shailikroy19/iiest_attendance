import 'package:flutter/material.dart';

class StudentSubjectHistoryTile extends StatelessWidget {
  final bool isPresent;

  const StudentSubjectHistoryTile({required this.isPresent});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.orange[100],
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(1.0, 1.0),
                blurRadius: 5,
              ),
              //BoxShadow
            ],
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: ListTile(
          title: Text(
            "24/04/2021",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          //TODO: date&time
          subtitle: Text(
            "14:32",
          ),
          trailing: Text(
            (isPresent) ? 'Present' : 'Absent',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: (isPresent) ? Colors.green : Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
