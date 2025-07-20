import 'package:flutter/material.dart';
import 'package:ministry/constants/appbar.dart';
import 'package:ministry/constants/notif_cart.dart';
import 'package:ministry/db/database.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotifPage extends StatefulWidget {
  const NotifPage({super.key});

  @override
  State<NotifPage> createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  List<String> titleContent = [];
  List<String> bodyContent = [];
  _getContents() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      titleContent = pref.getStringList("titleContent") ?? [];
      bodyContent = pref.getStringList("bodyContent") ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    _getContents();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar('الاشعارات'),
      body: FutureBuilder(
        future: getNotifactions(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return bodyContent.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: size.width - 20,
                    height: size.height,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: bodyContent.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return NotifCart(
                          title: titleContent[index],
                          bodyText: bodyContent[index],
                        );
                      },
                    ),
                  ),
                )
              : Center(
                  child: Lottie.asset(
                    './assets/images/Animation-bookmark.json',
                    width: 200,
                  ),
                );
        },
      ),
    );
  }
}
