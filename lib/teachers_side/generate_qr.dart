import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiest_attendance/colors.dart';
import 'package:iiest_attendance/widgets/generate_unique_id.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRCode extends StatefulWidget {
  final String uid;
  GenerateQRCode({required this.uid});
  @override
  _GenerateQRCodeState createState() => _GenerateQRCodeState();
}

class _GenerateQRCodeState extends State<GenerateQRCode> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();

    //String date = dateTime.toString().substring(0, 10);
    String rand = generateRandomString(20);

    String qrData = widget.uid + "#" + rand;

    dynamic updateAttendance(String uid) {
      User? currentUser = FirebaseAuth.instance.currentUser;

      FirebaseFirestore.instance
          .collection("Teachers")
          .doc(currentUser!.email)
          .update({'qr': qrData});
    }

    updateAttendance(widget.uid);
    Timer timer = Timer(Duration(seconds: 20), () {
      updateAttendance(widget.uid);
      setState(() {
        rand = generateRandomString(20);
      });
    });

    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 15.0, top: 15.0, bottom: 10.0),
                    child: Column(
                      children: [
                        Text(
                          'Take Attendance',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        //super.dispose();
                        timer.cancel();
                        Navigator.of(context).pop();
                      },
                      child:
                          Text('Stop', style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(primary: Colors.red[200]),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 5.0),
                child: SelectableText(
                  "Date: " + dateTime.toString().substring(0, 10),
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              gradient: iiestGradient, backgroundBlendMode: BlendMode.multiply),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 72.0),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                shape: BoxShape.rectangle,
                gradient: iiestGradient,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: QrImage(
                  foregroundColor: Colors.black,
                  data: qrData,
                  version: QrVersions.auto,
                  size: 165.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22.0, 10.0, 22.0, 10.0),
            child: Text(
              'Students must scan this QR Code with their phone to register their respective attenadnces. QR Code changes every 20 seconds.',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
