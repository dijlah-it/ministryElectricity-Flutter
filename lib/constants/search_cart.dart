import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ministry/constants/constants.dart';

class SearchCart extends StatelessWidget {
  final int status;
  final String complaintsId;
  final String explanation;
  const SearchCart({
    super.key,
    required this.status,
    required this.complaintsId,
    required this.explanation,
  });

  @override
  Widget build(BuildContext context) {
    String? condition;
    Color? conditionColor;
    switch (status) {
      case 0:
        condition = 'قيد الاستلام';
        conditionColor = const Color.fromARGB(255, 198, 40, 40);
        break;
      case 1:
        condition = 'تم الاستلام';
        conditionColor = const Color.fromARGB(255, 21, 101, 192);
        break;
      case 2:
        condition = 'تم الانجاز';
        conditionColor = const Color.fromARGB(255, 46, 125, 50);
        break;
      default:
    }

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: <Widget>[
          Container(
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
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black45,
                              width: 0.0,
                            ),
                          ),
                        ),
                        child: Text(
                          complaintsId,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: Constants.regularFontFamily,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: conditionColor,
                        ),
                        child: Text(
                          
                          condition!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: Constants.regularFontFamily,
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    explanation,
                    style: const TextStyle(
                      fontFamily: Constants.regularFontFamily,
                      color: Colors.black87,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
          const Gap(20)
        ],
      ),
    );
  }
}
