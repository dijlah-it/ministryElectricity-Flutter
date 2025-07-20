import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ministry/constants/appbar.dart';
import 'package:ministry/constants/constants.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:substring_highlight/substring_highlight.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  static const List<Object> _callNumberItems = [
    {"number": 5608, "text": 'مقرالوازره (5608)'},
    {"number": 157, "text": 'توزيع الكرخ (157)'},
    {"number": 158, "text": 'توزيع الرصاف (158)'},
    {"number": 1012, "text": 'توزيع الصدر (1012)'},
    {"number": 159, "text": 'باقي المحافظات (159)'},
  ];
  @override
  Widget build(BuildContext context) {
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
                  margin: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: switch (item) {
                    {
                      'text': final String text,
                      'number': final int number,
                    } =>
                      GestureDetector(
                        onTap: () {
                          debugPrint(number.toString());
                          FlutterPhoneDirectCaller.callNumber(
                              number.toString());
                        },
                        child: CallItem(
                          text: text,
                          term: number.toString(),
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

class CallItem extends StatelessWidget {
  final String text;
  final String term;

  const CallItem({
    super.key,
    required this.text,
    required this.term,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      clipBehavior: Clip.antiAlias,
      width: size.width * 0.7,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Constants.lightThemeColor,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              color: Constants.lightThemeColor,
            ),
            child: const Icon(
              Icons.call_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 4,
              ),
              child: SubstringHighlight(
                text: text,
                term: term,
                textStyle: const TextStyle(
                  fontFamily: Constants.regularFontFamily,
                  color: Constants.lightThemeColor,
                  fontSize: 22,
                ),
                textStyleHighlight: const TextStyle(
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
