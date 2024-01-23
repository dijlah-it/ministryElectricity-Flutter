import 'package:flutter/material.dart';
import 'package:ministry/constants/constants.dart';

AppBar appBar(String title) {
  return AppBar(
    backgroundColor: Constants.lightThemeColor,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontFamily: Constants.regularFontFamily,
        fontSize: 16,
      ),
    ),
  );
}
