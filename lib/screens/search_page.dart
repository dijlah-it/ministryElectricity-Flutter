import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ministry/api/ministry_api.dart';
import 'package:ministry/constants/appbar.dart';
import 'package:ministry/constants/constants.dart';
import 'package:ministry/constants/search_cart.dart';
import 'package:ministry/db/database.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchFormKey = GlobalKey<FormState>();
  final controllerSearchComplaints = TextEditingController();
  late List<dynamic> _listComplaints;
  bool getdata = false;
  @override
  void initState() {
    super.initState();
    getCodes('').then((value) {
      getUserComplaints(Constants.stringCodes).then((value) {
        setState(() {
          _listComplaints = Constants.userComplaints!;
          getdata = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar('متابعة شكوى'),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        height: size.height,
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: <Widget>[
                Form(
                  key: searchFormKey,
                  child: TextFormField(
                    controller: controllerSearchComplaints,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                        borderSide:
                            BorderSide(color: Constants.lightThemeColor),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                        borderSide:
                            BorderSide(color: Constants.lightThemeColor),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      helperText:
                          'للاستعلام عن نتيجة الشكوى يرجى ادخال رقم المتابعة',
                      helperStyle: const TextStyle(
                        fontFamily: Constants.regularFontFamily,
                        color: Constants.lightThemeColor,
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          Constants.stringCodes = 'track/';
                          setState(() {
                            _listComplaints.clear();
                            getdata = false;
                          });
                          getCodes(controllerSearchComplaints.text)
                              .then((value) {
                            getUserComplaints(Constants.stringCodes)
                                .then((value) {
                              setState(() {
                                _listComplaints = Constants.userComplaints!;
                                getdata = true;
                              });
                            });
                          });
                        },
                        child: const Icon(
                          Icons.search,
                          color: Constants.lightThemeColor,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: Constants.regularFontFamily,
                    ),
                  ),
                ),
                const Gap(25),
                SingleChildScrollView(
                  child: getdata
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: _listComplaints.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return SearchCart(
                              status: _listComplaints[index]['status'],
                              complaintsId: _listComplaints[index]
                                  ['id_at_their_database'],
                              explanation: _listComplaints[index]['details'],
                            );
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
