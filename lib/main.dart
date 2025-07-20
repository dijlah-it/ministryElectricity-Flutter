import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ministry/api/firebase_api.dart';
import 'package:ministry/constants/constants.dart';
import 'package:ministry/db/database.dart';
import 'package:ministry/screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final result = await InternetAddress.lookup('google.com');
  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    debugPrint('connected');
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.subscribeToTopic("general");
    await FirebaseApi().inintNotifications();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  InitializeDB initializeDB = InitializeDB();

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    initializeDB.initDb();
    
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      Constants.packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Constants.lightThemeColor),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
