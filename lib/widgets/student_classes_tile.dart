import 'package:flutter/material.dart';

class StudentClassTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DSA'),
                SizedBox(
                  height: 20,
                ),
                Text('IT 2101'),
              ],
            ),
            Column(),
            Column(),
          ],
        ),
      ),
    );
  }
}
