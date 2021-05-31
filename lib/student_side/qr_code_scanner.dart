import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

//void main() => runApp(MaterialApp(home: QRViewExample()));

class QRViewExample extends StatefulWidget {
  final String uid;
  QRViewExample({required this.uid});
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var now = DateTime.now();
  var date;
  @override

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  //GIVE ATTENDANCE METHOD//GIVE ATTENDANCE METHOD//GIVE ATTENDANCE METHOD//GIVE ATTENDANCE METHOD
  //GIVE ATTENDANCE METHOD//GIVE ATTENDANCE METHOD//GIVE ATTENDANCE METHOD//GIVE ATTENDANCE METHOD
  //GIVE ATTENDANCE METHOD//GIVE ATTENDANCE METHOD//GIVE ATTENDANCE METHOD//GIVE ATTENDANCE METHOD
  List attendanceList = [];
  dynamic giveAttendance(String code) {
    if (code.substring(0, 6) != widget.uid) {
      Fluttertoast.showToast(
        msg: 'Invalid QR Code for this class',
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        fontSize: 15.0,
        backgroundColor: Colors.black54,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      return FirebaseFirestore.instance
          .collection("Teachers")
          .where('qr', isEqualTo: code)
          .get()
          .then((value) {
        bool isAlreadyPresent = false;
        String teacherEmail = value.docs[0].id;
        String studentEmail =
            FirebaseAuth.instance.currentUser!.email.toString();
        attendanceList = value.docs[0]['${widget.uid}'];
        for (int i = 0; i < attendanceList.length; i++) {
          if (attendanceList[i]['email'] == studentEmail) {
            isAlreadyPresent = true;
            break;
          }
        }
        if (isAlreadyPresent) {
          Fluttertoast.showToast(
            msg: 'Attendance already given!',
            toastLength: Toast.LENGTH_LONG,
            textColor: Colors.white,
            fontSize: 15.0,
            backgroundColor: Colors.black54,
            gravity: ToastGravity.BOTTOM,
          );
        } else {
          date = now.day.toString() +
              '-' +
              now.month.toString() +
              '-' +
              now.year.toString();
          attendanceList.add({'email': studentEmail, 'date': date});
          FirebaseFirestore.instance
              .collection("Teachers")
              .doc(teacherEmail)
              .update({'${widget.uid}': attendanceList}).then((value) {
            Fluttertoast.showToast(
              msg: 'Attendance given sucessfully',
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              fontSize: 15.0,
              backgroundColor: Colors.black54,
              gravity: ToastGravity.BOTTOM,
            );
          });
        }
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(
          msg: 'Invalid QR Code',
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          fontSize: 15.0,
          backgroundColor: Colors.black54,
          gravity: ToastGravity.BOTTOM,
        );
      });
    }
  }

  //GIVE ATTENDANCE METHOD//GIVE ATTENDANCE METHOD//GIVE ATTENDANCE METHOD//GIVE ATTENDANCE METHOD
  //GIVE ATTENDANCE METHOD//GIVE ATTENDANCE METHOD//GIVE ATTENDANCE METHOD//GIVE ATTENDANCE METHOD
  //GIVE ATTENDANCE METHOD//GIVE ATTENDANCE METHOD//GIVE ATTENDANCE METHOD//GIVE ATTENDANCE METHOD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Scan QR Code from teacher\'s phone',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Set the QR Code within the designated area and press the \"Give Attendance\" button to register your attendance.',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Container(
                  //   margin: EdgeInsets.all(8),
                  //   child: ElevatedButton(
                  //       onPressed: () async {
                  //         await controller?.toggleFlash();
                  //         setState(() {});
                  //       },
                  //       child: FutureBuilder(
                  //         future: controller?.getFlashStatus(),
                  //         builder: (context, snapshot) {
                  //           return Text('Toggle Flash');
                  //         },
                  //       )),
                  // ),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.green[200]),
                      onPressed: (result == null)
                          ? null
                          : () {
                              //Todo: Add Code to Join class
                              //---------------------------------------------
                              giveAttendance(result!.code);
                              Navigator.pop(context);
                            },
                      child: Text(
                          (result == null) ? 'Scan a Code' : 'Give attendance',
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: IconButton(
                      onPressed: () async {
                        await controller?.flipCamera();
                        setState(() {});
                      },
                      icon:
                          Icon(Icons.cameraswitch_outlined, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
