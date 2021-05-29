import 'package:flutter/material.dart';
import 'package:iiest_attendance/colors.dart';

class StudentHomePage extends StatefulWidget {
  final String name, enrol, email;
  const StudentHomePage(
      {required this.name, required this.enrol, required this.email});
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
                child: Text(
                  'Attendance Portal',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              Tooltip(
                message: 'View Profile',
                child: InkWell(
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                width: size.width,
                                height: 22.0,
                                decoration: BoxDecoration(
                                  gradient: iiestGradient,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0)),
                                ),
                                child: Center(
                                    child: Text(
                                  'Student Profile',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                )),
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
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.black,
                                              ),
                                              radius: 30.0,
                                              backgroundColor: Colors.grey),
                                        ),
                                        title: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                    text: widget.name,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal),
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
                                                    text: widget.enrol,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        subtitle: SelectableText.rich(
                                          TextSpan(
                                            text: widget.email,
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.red[300]),
                                          onPressed: () {},
                                          icon: Icon(Icons.logout_outlined,
                                              color: Colors.black),
                                          label: Text(
                                            'LOGOUT',
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.account_circle_outlined,
                      size: 28.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              gradient: iiestGradient, backgroundBlendMode: BlendMode.multiply),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 55.0),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Classes')],
          ),
        ),
      ),
    );
  }
}
