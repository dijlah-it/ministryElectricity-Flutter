import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ministry/constants/constants.dart';
import 'package:ministry/screens/call_page.dart';
import 'package:ministry/screens/content_page.dart';
import 'package:ministry/screens/notif_page.dart';
import 'package:ministry/screens/search_page.dart';
import 'package:ministry/screens/send_complaint_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<String> _mainButtons = [
    './assets/images/co-03.png',
    './assets/images/co-02.png',
    './assets/images/co-04.png',
    './assets/images/co-05.png',
  ];
  static const List<String> _drawerItemsTitles = [
    'الصفحة الرئيسية',
    'ارسال شكوى',
    'متابعة شكوى',
    'الاتصال بمركز الشكاوى',
    'حول التطبيق',
    'ارشادات',
    'الاشعارات',
    'مشاركة التطبيق',
  ];
  static const List<IconData> _drawerItemsIcons = [
    Icons.home,
    Icons.send,
    Icons.search,
    Icons.call,
    Icons.warning_rounded,
    Icons.question_mark,
    Icons.notifications_active,
    Icons.share,
  ];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool showSendComplaint = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        showSendComplaint = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Image.asset(
                './assets/images/headerDrawer.png',
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: List.generate(
                    _drawerItemsTitles.length,
                    (index) => BuildDrawerItem(
                      icon: _drawerItemsIcons[index],
                      title: _drawerItemsTitles[index],
                      tag: index,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            //background img
            Image.asset(
              './assets/images/homeScreen.jpg',
              fit: BoxFit.fitHeight,
              height: size.height,
            ),
            //appbar
            Positioned(
              top: 40,
              child: SizedBox(
                width: size.width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        scaffoldKey.currentState?.openDrawer();
                      },
                      child: const Icon(
                        Icons.menu,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: const NotifPage(),
                            type: PageTransitionType.leftToRight,
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.notification_important,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //logo
            Positioned(
              top: 165,
              right: 105,
              child: Image.asset(
                './assets/images/logoInHome.png',
                width: 190,
                height: 190,
              ),
            ),
            //sendComplaint
            AnimatedPositioned(
              bottom: showSendComplaint ? 30 : -60,
              duration: const Duration(milliseconds: 500),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: const SendComplaintPage(),
                      type: PageTransitionType.leftToRight,
                    ),
                  );
                },
                child: Image.asset(
                  './assets/images/sendComplaint.png',
                  width: 200,
                ),
              ),
            ),
            // buttons
            Padding(
              padding: const EdgeInsets.only(
                top: 220,
                right: 20,
                left: 20,
              ),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                childAspectRatio:
                    (((size.height - kToolbarHeight) / 1.5) / (size.width)),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: List.generate(
                  _mainButtons.length,
                  (index) => BuildMainButton(
                    imgPath: _mainButtons[index],
                    tag: index,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildMainButton extends StatelessWidget {
  final String imgPath;
  final int tag;
  const BuildMainButton({
    super.key,
    required this.imgPath,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint(tag.toString());
        switch (tag) {
          case 0:
            Navigator.push(
              context,
              PageTransition(
                child: const CallPage(),
                type: PageTransitionType.leftToRight,
              ),
            );
            break;
          case 1:
            Navigator.push(
              context,
              PageTransition(
                child: const SearchPage(),
                type: PageTransitionType.leftToRight,
              ),
            );
            break;
          case 2:
            Navigator.push(
              context,
              PageTransition(
                child: const ContentPage(
                  title: 'حول التطبيق',
                ),
                type: PageTransitionType.leftToRight,
              ),
            );
            break;
          case 3:
            Navigator.push(
              context,
              PageTransition(
                child: const ContentPage(
                  title: 'ارشادات',
                ),
                type: PageTransitionType.leftToRight,
              ),
            );
            break;
          default:
        }
      },
      child: Image.asset(
        imgPath,
      ),
    );
  }
}

class BuildDrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final int tag;
  const BuildDrawerItem({
    super.key,
    required this.title,
    required this.icon,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint(tag.toString());
        switch (tag) {
          case 0:
            Navigator.of(context).pop(false);
            break;
          case 1:
            Navigator.push(
              context,
              PageTransition(
                child: const SendComplaintPage(),
                type: PageTransitionType.leftToRight,
              ),
            );
            break;
          case 2:
            Navigator.push(
              context,
              PageTransition(
                child: const SearchPage(),
                type: PageTransitionType.leftToRight,
              ),
            );
            break;
          case 3:
            Navigator.push(
              context,
              PageTransition(
                child: const CallPage(),
                type: PageTransitionType.leftToRight,
              ),
            );
            break;
          case 4:
            Navigator.push(
              context,
              PageTransition(
                child: const ContentPage(
                  title: 'حول التطبيق',
                ),
                type: PageTransitionType.leftToRight,
              ),
            );
            break;
          case 5:
            Navigator.push(
              context,
              PageTransition(
                child: const ContentPage(
                  title: 'ارشادات',
                ),
                type: PageTransitionType.leftToRight,
              ),
            );
            break;
          case 6:
            Navigator.push(
              context,
              PageTransition(
                child: const NotifPage(),
                type: PageTransitionType.leftToRight,
              ),
            );
            break;
          case 7:
            final box = context.findRenderObject() as RenderBox?;
            Share.share(
              "أدعوك للاطلاع على تطبيق (${Constants.packageInfo.appName}) وذلك عبر الرابط التالي: \n https://play.google.com/store/apps/details?id=${Constants.packageInfo.packageName}",
              subject: "المشاركة ضمن:",
              sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
            );
            break;
          default:
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.grey,
            ),
            const Gap(15),
            Text(
              title,
              style: const TextStyle(
                fontFamily: Constants.regularFontFamily,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
