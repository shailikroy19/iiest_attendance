import 'package:flutter/material.dart';
import 'package:iiest_attendance/login_page/first_screen.dart';
import 'package:iiest_attendance/login_page/login_web.dart';

final Gradient iiestGradient = LinearGradient(
    colors: [Color(0xCC97C74E), Color(0xFF2AB9A5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

//IIEST LOGO
Widget logoIIEST(double width) {
  return Container(
    width: width,
    child: Image(
      image: AssetImage('assets/iiest.png'),
      fit: BoxFit.contain,
    ),
  );
}

//STYLED DIVIDER
Widget customStyledDivider(double factor, IconData icon) {
  return Padding(
    padding:
        const EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0, bottom: 0.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: factor,
          child: Divider(
            thickness: 1.5,
            height: 5.0,
            color: Colors.black54,
          ),
        ),
        SizedBox(width: 10.0),
        Icon(icon, color: Colors.black54),
        SizedBox(width: 10.0),
        Container(
          width: factor,
          child: Divider(
            thickness: 1.5,
            height: 5.0,
            color: Colors.black54,
          ),
        ),
      ],
    ),
  );
}

//FOOTER
Widget iiestFooter(Color backgroundColor) {
  return Container(
    color: backgroundColor,
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.copyright, size: 17.0, color: Colors.black),
          Text(
            (' · ' + DateTime.now().toString().substring(0, 4) + ' · '),
            style: TextStyle(
              color: Colors.black,
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'IIEST, Shibpur',
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(' · All Rights Reserved',
              style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}

//alert dialog//alert dialog//alert dialog//alert dialog//alert dialog//alert dialog
//alert dialog//alert dialog//alert dialog//alert dialog//alert dialog//alert dialog
//alert dialog//alert dialog//alert dialog//alert dialog//alert dialog//alert dialog

showLogoutAlertDialog(BuildContext context) {
  // set up the button
  // ignore: deprecated_member_use
  Widget yesButton = FlatButton(
    splashColor: Colors.red[100],
    child: Text("Sign Out"),
    onPressed: () {
      //LOGOUT
      logoutUser().then((f) {
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (f) {
          return FirstScreen();
        }));
      });
    },
  );
  // ignore: deprecated_member_use
  Widget noButton = FlatButton(
    splashColor: Colors.green[100],
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    title: Text('Warning!',
        style: TextStyle(color: Colors.redAccent, fontSize: 22.0)),
    content: Text(
        'Are you sure you want to Sign Out?\n\nYou will need to sign in again the next time you open the app.',
        style: TextStyle(fontSize: 15.0)),
    actions: [
      yesButton,
      noButton,
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
