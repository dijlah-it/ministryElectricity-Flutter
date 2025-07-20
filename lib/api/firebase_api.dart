import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ministry/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> titleContent = [];
List<String> bodyContent = [];
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  debugPrint("title :${message.notification?.title}");
  debugPrint("body :${message.notification?.body}");
  debugPrint("payload :${message.data}");
  saveNotif(
      title: message.notification?.title, body: message.notification?.body);
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

saveNotif({String? body, String? title}) async {
  titleContent.add(title!);
  bodyContent.add(body!);

  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setStringList("titleContent", titleContent);
  await pref.setStringList("bodyContent", bodyContent);
}
