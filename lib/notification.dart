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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _safeDeviceToken();

  }


  Widget build(BuildContext context) {
    return Scaffold();
  }

  _safeDeviceToken() async {


    String uid = "";
    //  FirebaseUser firebaseUser = await _auth.currentUser();
    String fcmtoken =
    await _firebaseMessaging.getToken();
    print(" ${fcmtoken}");
    // to get token from firebase

  }
}
