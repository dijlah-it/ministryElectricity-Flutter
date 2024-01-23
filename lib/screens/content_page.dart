import 'package:flutter/material.dart';
import 'package:ministry/constants/constants.dart';

class ContentPage extends StatefulWidget {
  final String title;
  const ContentPage({
    super.key,
    required this.title,
  });

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.lightThemeColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontFamily: Constants.regularFontFamily,
            fontSize: 16,
          ),
        ),
      ),
      body: Center(
        child: Text('weqw'),
      ),
    );
  }
}

