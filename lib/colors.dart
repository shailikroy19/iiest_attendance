import 'package:flutter/material.dart';

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

Widget logoIIESTShort(double size) {
  return Container();
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
