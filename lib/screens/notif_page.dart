import 'package:flutter/material.dart';
import 'package:ministry/constants/appbar.dart';
import 'package:ministry/constants/constants.dart';
import 'package:ministry/constants/notif_cart.dart';
import 'package:ministry/db/database.dart';
import 'package:lottie/lottie.dart';

class NotifPage extends StatefulWidget {
  const NotifPage({super.key});

  @override
  State<NotifPage> createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar('الاشعارات'),
      body: FutureBuilder(
        future: getNotifactions(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Constants.notifactionsContentList.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: size.width - 20,
                    height: size.height,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: Constants.notifactionsContentList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return NotifCart(
                          title: Constants.notifactionsContentList[index]
                              ['title'],
                          bodyText: Constants.notifactionsContentList[index]
                              ['body'],
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
