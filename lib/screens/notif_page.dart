import 'package:flutter/material.dart';
import 'package:ministry/constants/appbar.dart';
import 'package:ministry/constants/constants.dart';

class NotifPage extends StatefulWidget {
  const NotifPage({super.key});

  @override
  State<NotifPage> createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('الاشعارات'),
    );
  }
}


