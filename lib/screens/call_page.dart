import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ministry/constants/appbar.dart';
import 'package:ministry/constants/constants.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  static const List<Object> _callNumberItems = [
    {"number": 5608, "image": './assets/images/co-tel-01.png'},
    {"number": 157, "image": './assets/images/co-tel-02.png'},
    {"number": 158, "image": './assets/images/co-tel-03.png'},
    {"number": 1012, "image": './assets/images/co-tel-04.png'},
    {"number": 159, "image": './assets/images/co-tel-05.png'},
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar('الاتصال بمركز الشكاوى'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            children: <Widget>[
              const Text(
                'يمكنك الاتصال بمركز شكاوى المواطنين على الارقام التالية: ',
                style: TextStyle(
                  fontFamily: Constants.regularFontFamily,
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
              const Gap(20),
              for (final item in _callNumberItems)
                Container(
                  child: switch (item) {
                    {
                      'image': final String image,
                      'number': final int number,
                    } =>
                      GestureDetector(
                        onTap: () {
                          debugPrint(number.toString());
                          FlutterPhoneDirectCaller.callNumber(
                              number.toString());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Image.asset(
                            image,
                            width: size.width * 0.6,
                          ),
                        ),
                      ),
                    final v => throw Exception('what is $v'),
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
