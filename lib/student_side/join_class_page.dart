import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiest_attendance/colors.dart';

class JoinClass extends StatefulWidget {
  final List classList;
  JoinClass({required this.classList});
  @override
  _JoinClassState createState() => _JoinClassState();
}

class _JoinClassState extends State<JoinClass> {
  final _formKey = GlobalKey<FormState>();

  CollectionReference users = FirebaseFirestore.instance.collection('Teachers');

  TextEditingController uidX = new TextEditingController();

  dynamic joinClassMethod(String uid) {
    return users
        .where('classes', arrayContains: {'uid': uid})
        .get()
        .then((value) {
          //Fluttertoast.showToast(msg: 'Class Joined Sucesfully!');
          print(value.docs.toString());
          Navigator.of(context).pop();
        })
        .onError((error, stackTrace) {
          Fluttertoast.showToast(msg: 'Error Occured: ' + error.toString());
        });
    // return users
    //     .doc(widget.email)
    //     .update({'classes': widget.classesList}).then((value) {

    // }).catchError((error) {
    //   Fluttertoast.showToast(msg: 'An Unexpected Error Occured!');
    // });
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
                          joinClassMethod(uidX.text);
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
