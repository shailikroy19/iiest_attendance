import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

Future loginUser(String email, String password) async {
  //initialize app
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email!');
      Fluttertoast.showToast(
        msg: 'No user found with that email!',
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        fontSize: 15.0,
        backgroundColor: Colors.black54,
      );
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user!');
      Fluttertoast.showToast(
        msg: 'Wrong password!',
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.red,
        fontSize: 15.0,
        backgroundColor: Colors.black54,
      );
    } else {
      if (e.code == 'invalid-email') {
        Fluttertoast.showToast(
          msg: 'Invalid Email Address!',
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          fontSize: 15.0,
          backgroundColor: Colors.black54,
        );
      } else {
        print('An Error Occured!');
        Fluttertoast.showToast(
          msg: 'An Unexpected Error Occured!',
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          fontSize: 15.0,
          backgroundColor: Colors.black54,
        );
      }
    }
  }
}

Future logoutUser() async {
  try {
    var xyz = await FirebaseAuth.instance.signOut();
    return xyz;
  } on FirebaseAuthException catch (e) {
    print(e.code);
    Fluttertoast.showToast(
      msg: 'Something Went Wrong!',
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.red,
      fontSize: 15.0,
      backgroundColor: Colors.black54,
    );
  }
}
