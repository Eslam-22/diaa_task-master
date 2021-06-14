import 'package:diaa_task/notification.dart';
import 'package:flutter/material.dart';
import 'clientsite.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'عقار الكويت',

      // home : Notificatin(),
      home : ClientSite(),
    );
  }
}


