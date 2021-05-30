import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiest_attendance/colors.dart';

class JoinClass extends StatefulWidget {
  final List classList;
  final String email;
  JoinClass({required this.classList, required this.email});
  @override
  _JoinClassState createState() => _JoinClassState();
}

class _JoinClassState extends State<JoinClass> {
  final _formKey = GlobalKey<FormState>();

  CollectionReference users = FirebaseFirestore.instance.collection('Teachers');

  CollectionReference usersx =
      FirebaseFirestore.instance.collection('Students');

  TextEditingController uidX = new TextEditingController();

  dynamic check(String uid) {
    return usersx.doc(widget.email).get().then((value) {
      List list = value['classes'];
      for (int i = 0; i < list.length; i++) {
        if (list[i]['uid'] == uid) {
          Fluttertoast.showToast(
            msg: 'Class already Present!',
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            fontSize: 15.0,
            backgroundColor: Colors.black54,
            gravity: ToastGravity.BOTTOM,
          );
          Navigator.of(context).pop();
          return;
        }
      }
      joinClassMethod(uidX.text);
    });
  }

  dynamic addClass(Map map, String uid) {
    widget.classList.add(map);
    return usersx
        .doc(widget.email)
        .update({'classes': widget.classList}).then((value) {
      Fluttertoast.showToast(
        msg: 'Class Joined Sucesfully!',
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        fontSize: 15.0,
        backgroundColor: Colors.black54,
        gravity: ToastGravity.BOTTOM,
      );
      widget.classList.clear();
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: 'An Unexpected Error Occured!\n\n' + error.toString(),
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.red,
        fontSize: 15.0,
        backgroundColor: Colors.black54,
        gravity: ToastGravity.BOTTOM,
      );
    });
  }

  dynamic joinClassMethod(String uid) {
    //check(uid);
    bool isFound = false;
    Map xyz = {};
    List abc = [];
    return users.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        abc = element['classes'];
        for (int i = 1; i < abc.length; i++) {
          xyz = abc[i];
          if (xyz['uid'] == uid) {
            isFound = true;
            break;
          }
        }
      });
      if (isFound) {
        addClass(xyz, uid);
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(
          msg: 'Class Not Found... Please check code',
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          fontSize: 15.0,
          backgroundColor: Colors.black54,
          gravity: ToastGravity.BOTTOM,
        );
        //Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.arrow_back)),
                      Text(
                        'Join a Class',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
              gradient: iiestGradient, backgroundBlendMode: BlendMode.multiply),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 55.0),
      ),
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffC9FFD9), Colors.white12],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft)),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      maxLength: 6,
                      controller: uidX,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter class code";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter 6 digit class code (Unique)",
                        contentPadding: EdgeInsets.only(top: 14.0, left: 14.0),
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        filled: true,
                        fillColor: Colors.green.withOpacity(0.3),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {}
                          if (uidX.text != "") {
                            check(uidX.text);
                          }
                        },
                        icon: Icon(Icons.add, color: Colors.black),
                        label: Text('Join Class',
                            style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange[200],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
