import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iiest_attendance/colors.dart';
import 'package:iiest_attendance/widgets/generate_unique_id.dart';

class CreateClass extends StatefulWidget {
  final String email;
  final List classesList;
  const CreateClass({required this.email, required this.classesList});
  @override
  _CreateClassState createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  final _formKey = GlobalKey<FormState>();

  CollectionReference users = FirebaseFirestore.instance.collection('Teachers');

  TextEditingController subjName = new TextEditingController();
  TextEditingController subjCode = new TextEditingController();
  TextEditingController sem = new TextEditingController();

  Future<void> addClass(String uid) {
    widget.classesList.add({
      'subj_name': subjName.text,
      'subj_code': subjCode.text,
      'sem': sem.text,
      'uid': uid,
    });
    return users
        .doc(widget.email)
        .update({'classes': widget.classesList}).then((value) {
      Fluttertoast.showToast(
        msg: 'Class Added Sucesfully!',
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        fontSize: 15.0,
        backgroundColor: Colors.black54,
        gravity: ToastGravity.BOTTOM,
      );
      widget.classesList.clear();
      Navigator.of(context).pop();
      showCodeAlertDialog(context, uid);
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: 'An Unexpected Error Occured!\n\n' + error.toString(),
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        fontSize: 15.0,
        backgroundColor: Colors.black54,
        gravity: ToastGravity.BOTTOM,
      );
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
                        'Create Class',
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
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter subject name";
                        }
                        return null;
                      },
                      controller: subjName,
                      decoration: InputDecoration(
                        hintText: "Enter subject name",
                        contentPadding: EdgeInsets.only(top: 14.0, left: 14.0),
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        filled: true,
                        fillColor: Colors.green.withOpacity(0.3),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter subject code";
                        }
                        return null;
                      },
                      controller: subjCode,
                      decoration: InputDecoration(
                        hintText: "Enter subject code",
                        contentPadding: EdgeInsets.only(top: 14.0, left: 14.0),
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        filled: true,
                        fillColor: Colors.green.withOpacity(0.3),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter semester";
                        }
                        return null;
                      },
                      controller: sem,
                      decoration: InputDecoration(
                        hintText: "Enter semester",
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
                          String uid = generateRandomString(6);

                          addClass(uid);
                        },
                        icon: Icon(Icons.add, color: Colors.black),
                        label: Text('Create Class',
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
