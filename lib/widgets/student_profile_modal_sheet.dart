import 'package:flutter/material.dart';
import 'package:iiest_attendance/colors.dart';

Future<dynamic> StudentModalSheet(
    BuildContext context, Size size, String name, String enrol, String email) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: size.width,
            //height: 30.0,
            decoration: BoxDecoration(
              gradient: iiestGradient,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                  child: Text(
                'Student Profile',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
          Container(
            width: size.width,
            //height: size.height / 2.3,
            height: 180.0,
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Container(
                      width: 50.0,
                      child: CircleAvatar(
                        child: Center(
                          child: Text(
                            name.substring(0, 1).toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                                color: Colors.black),
                          ),
                        ),
                        radius: 30.0,
                        backgroundColor: Colors.green[100],
                      ),
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText.rich(
                          TextSpan(
                            text: "Name: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        SelectableText.rich(
                          TextSpan(
                            text: "Enrol: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: enrol,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    subtitle: SelectableText.rich(
                      TextSpan(
                        text: email,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: Colors.red[300]),
                      onPressed: () {
                        showLogoutAlertDialog(context);
                      },
                      icon: Icon(Icons.logout_outlined, color: Colors.black),
                      label: Text(
                        'LOGOUT',
                        style: TextStyle(color: Colors.black),
                      )),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
