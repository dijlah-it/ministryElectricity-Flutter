import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ministry/constants/constants.dart';
import 'package:ministry/db/database.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  debugPrint("title :${message.notification?.title}");
  debugPrint("body :${message.notification?.body}");
  debugPrint("payload :${message.data}");





  // final service = FlutterBackgroundService();
  // await service.configure(
  //   androidConfiguration: AndroidConfiguration(
  //     onStart: saveNotif(
  //       title: message.notification?.title,
  //       body: message.notification?.body,
  //     ),
  //     autoStart: true,
  //     isForegroundMode: true,
  //   ),
  //   iosConfiguration: IosConfiguration(
  //     autoStart: true,
  //     onForeground: saveNotif(
  //       title: message.notification?.title,
  //       body: message.notification?.body,
  //     ),
  //   ),
  // );
  // service.startService();

  
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> inintNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();
    debugPrint("TOKEN :$fCMToken");
    Constants.userToken = fCMToken!;
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
