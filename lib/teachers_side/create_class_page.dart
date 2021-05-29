import 'package:flutter/material.dart';
import 'package:iiest_attendance/colors.dart';

class CreateClass extends StatefulWidget {
  @override
  _CreateClassState createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  final _formKey = GlobalKey<FormState>();
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
          Padding(
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
                    decoration: InputDecoration(
                      hintText: "Enter semester",
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
                        return "Please enter class code";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter class code (Unique)",
                      contentPadding: EdgeInsets.only(top: 14.0, left: 14.0),
                      border: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      filled: true,
                      fillColor: Colors.green.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          if (_formKey.currentState!.validate()) {}
        },
        child: Icon(
          Icons.add_rounded,
          size: 30.0,
        ),
      ),
    );
  }
}
