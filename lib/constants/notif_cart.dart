import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ministry/constants/constants.dart';

class NotifCart extends StatelessWidget {
  final String title;
  final String bodyText;

  const NotifCart({
    super.key,
    required this.title,
    required this.bodyText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2,
                  offset: Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset(
                      './assets/images/logoInHome.png',
                      width: 30,
                      height: 30,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: Constants.regularFontFamily,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                Text(
                  bodyText,
                  style: const TextStyle(
                    fontFamily: Constants.regularFontFamily,
                    color: Colors.black87,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                )
              ],
            ),
          ),
          const Gap(10),
        ],
      ),
    );
  }
}
