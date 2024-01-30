import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Constants {
  static const String regularFontFamily = 'dijlah-Regular';
  static const Color lightThemeColor = Color.fromRGBO(15, 28, 104, 1);

  static PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  static List<dynamic> notifactionsContentList = [];
  static String stringCodes = 'track/';
  static List<dynamic>? userComplaints;
  static String userToken ='';
}
