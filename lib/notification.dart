import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Notificatin extends StatefulWidget {
  @override
  _NotificatinState createState() => _NotificatinState();
}

class _NotificatinState extends State<Notificatin> {
  @override
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final Firestore _db = Firestore.instance;
  void initstate() {
// https://q8aqar.com/inc/app/sendtokenid.php
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold();
  }

  _safeDeviceToken() async {
    String uid = "";
    //  FirebaseUser firebaseUser = await _auth.currentUser();
    String fcmtoken =
        await _firebaseMessaging.getToken(); // to get token from firebase
    if (fcmtoken != null) {
      var tokens = _db
          .collection('users')
          .document(uid)
          .collection('tokens')
          .document(fcmtoken);

      await tokens.setData({
        'token': fcmtoken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
  }
}
