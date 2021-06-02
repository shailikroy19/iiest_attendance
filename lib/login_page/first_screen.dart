import 'package:flutter/material.dart';
import 'package:iiest_attendance/colors.dart';
import 'package:iiest_attendance/login_page/login_screen.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          //color: Color(0xFFB388FF),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 45.0, left: 10.0, right: 10.0, bottom: 5.0),
                child: logoIIEST(size.width / 1.3),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 15.0),
                child: Text(
                  'ATTENDANCE COLLECTION PORTAL',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
                child: Container(
                  height: 220,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage('assets/iiest_old.jpg'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'For Registered Students',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(bottom: 8.0),
                              //   child: Text(
                              //     '100',

                              //     style: TextStyle(
                              //         fontSize: 15.0,
                              //         color: Colors.blue,
                              //         fontWeight: FontWeight.bold),
                              //   ),
                              // ),
                            ],
                          ),
                          Container(
                            width: size.width / 2.5,
                            height: 60.0,
                            decoration: BoxDecoration(
                              gradient: iiestGradient,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (f) =>
                                        LoginScreen(name: 'STUDENT LOGIN')));
                              },
                              child: Text('STUDENT LOGIN',
                                  style: TextStyle(color: Colors.black)),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                elevation: 0.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        color: Colors.black,
                        thickness: 1.0,
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'For Registered Teachers',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(bottom: 8.0),
                              //   child: Text(
                              //     '10',
                              //
                              //     style: TextStyle(
                              //         fontSize: 15.0,
                              //         color: Colors.blue,
                              //         fontWeight: FontWeight.bold),
                              //   ),
                              // ),
                            ],
                          ),
                          Container(
                            width: size.width / 2.5,
                            height: 60.0,
                            decoration: BoxDecoration(
                              gradient: iiestGradient,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (f) =>
                                        LoginScreen(name: 'TEACHER LOGIN')));
                              },
                              child: Text('TEACHER LOGIN',
                                  style: TextStyle(color: Colors.black)),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                elevation: 0.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     child: Text('CREATE ACCOUNT',
              //         style: TextStyle(color: Colors.black)),
              //     style: ElevatedButton.styleFrom(
              //       primary: Colors.amber[200],
              //       elevation: 4.0,
              //       minimumSize: Size?.square(40.0),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    showAlertDialog(
                      context,
                      'Important Instructions',
                      'Use the G-Suite Email ID or the Institute email id provided to you by IIEST Shibpur.',
                    );
                  },
                  icon: Icon(Icons.info_outline, color: Colors.black),
                  label: Text('Important Instructions',
                      style: TextStyle(color: Colors.black)),
                  style:
                      ElevatedButton.styleFrom(primary: Colors.blueAccent[100]),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: iiestFooter(Colors.white),
    );
  }
}
