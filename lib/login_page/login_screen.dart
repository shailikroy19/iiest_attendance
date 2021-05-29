import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiest_attendance/colors.dart';
import 'package:iiest_attendance/home_page/home_screen.dart';
import 'package:iiest_attendance/login_page/login_web.dart';

class LoginScreen extends StatefulWidget {
  final String name;
  LoginScreen({required this.name});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscured = true;

  bool isChecked = false;

  bool flag = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget loginCard(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: 15.0, left: 8.0, right: 8.0, bottom: 3.0),
      child: Container(
        width: 305.0,
        height: 455.0,
        decoration: BoxDecoration(
          //color: Colors.teal[200],
          gradient: iiestGradient,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.name,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email_outlined),
                      labelText: 'Email',
                      hintText: 'Enter registered email id',
                    ),
                    cursorColor: Colors.purple,
                  ),
                ),
                Container(
                  height: 70.0,
                  child: ListTile(
                    title: Container(
                      height: 70.0,
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock_outline),
                          labelText: 'Password',
                          hintText: 'Enter Password',
                        ),
                        obscureText: isObscured,
                        cursorColor: Colors.purple,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscured = !isObscured;
                        });
                      },
                      icon: Icon(
                        (isObscured)
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                //#####################################################################################################
                //#####################################################################################################
                //#####################################################################################################
                //#####################################################################################################
                //FIREBASE LOGIN CODE
                (flag)
                    ? FutureBuilder(
                        future: loginUser(
                            emailController.text, passwordController.text),
                        // ignore: missing_return
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Center(
                                  child:
                                      LinearProgressIndicator(minHeight: 2.0)),
                            );
                          }
                          flag = false;
                          if (snapshot.hasData) {
                            Future.delayed(Duration(milliseconds: 100), () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (f) =>
                                      HomeScreen(user: snapshot.data)));
                            });
                          }
                          return Container();
                        },
                      )
                    : SizedBox(height: 0.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 5.0),
                  child: Container(
                    width: 130.0,
                    height: 40.0,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      onPressed: () async {
                        // if (widget.type) {
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (f) => TeacherHomePage(
                        //           name: "Demo Teacher",
                        //           email: "demo@demo.com")));
                        // } else {

                        // }
                        //??????????????????????????????????????????????????
                        //??????????????????????????????????????????????????
                        // Navigator.of(context).pushReplacement(
                        //     MaterialPageRoute(builder: (f) => HomeScreen()));
                        // CALLING WEB SERVICE
                        if (emailController.text == '' ||
                            passwordController.text == '') {
                          Fluttertoast.showToast(
                            msg: 'Enter Valid Credentials!',
                            toastLength: Toast.LENGTH_LONG,
                            textColor: Colors.white,
                            fontSize: 15.0,
                            backgroundColor: Colors.black54,
                            gravity: ToastGravity.BOTTOM,
                          );
                        } else {
                          if (!isChecked) {
                            Fluttertoast.showToast(
                              msg: 'Please Agree to the Terms and Conditions!',
                              toastLength: Toast.LENGTH_SHORT,
                              textColor: Colors.white,
                              fontSize: 15.0,
                              backgroundColor: Colors.black54,
                              gravity: ToastGravity.BOTTOM,
                            );
                          } else {
                            setState(() {
                              flag = true;
                            });
                          }
                        }
                      },
                      color: Colors.amber[200],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.login_outlined),
                          Text(
                            'SIGN IN',
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // ignore: deprecated_member_use
                FlatButton.icon(
                  onPressed: () {
                    //open instruction page
                    showAlertDialog(
                      context,
                      'Important Instructions',
                      'Use the G-Suite Email ID or the Institute email id provided to you by IIEST Shibpur.',
                    );
                  },
                  icon: Icon(Icons.info_outline_rounded, size: 22.0),
                  label: Text('Important Instructions'),
                  splashColor: Colors.green[300],
                ),
                //custom divider
                customStyledDivider(92.3, Icons.spa_outlined),
                //custom divider
                SizedBox(height: 10.0),
                // ignore: deprecated_member_use
                FlatButton.icon(
                  onPressed: () {
                    //open instruction page
                    showAlertDialog(
                      context,
                      'Terms and Conditions',
                      'Declaration: I will not misuse the Attendance Collection Portal.',
                    );
                  },
                  icon: Icon(Icons.library_books_outlined, size: 22.0),
                  label: Text('Terms and Conditions'),
                  splashColor: Color(0xFFD1C4E9),
                ),
                SizedBox(height: 7.0),
                Container(
                  height: 30.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 37.0,
                        child: Checkbox(
                          activeColor: Colors.amber[200],
                          checkColor: Colors.black,
                          value: isChecked,
                          onChanged: (val) {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        child: Text(
                          'I agree to the Terms and Conditions',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
                padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                child: Text(
                  'ATTENDANCE COLLECTION PORTAL',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                ),
              ),
              //login card
              loginCard(context),
              //login card
            ],
          ),
        ),
      ),
      bottomNavigationBar: iiestFooter(Colors.white),
    );
  }
}

//#####################################################################################################
//#####################################################################################################
//#####################################################################################################
//#####################################################################################################
//alert dialog
showAlertDialog(BuildContext context, String header, String body) {
  // set up the button
  // ignore: deprecated_member_use
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(header),
    content: Text(body),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
