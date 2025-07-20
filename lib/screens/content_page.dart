import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ministry/constants/appbar.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
  late final String htmlPath;
  bool _showLinks = false;
  static const List<Object> _Links = [
    {"imagePath": './assets/images/youtube.png', "linkurl": ''},
    {"imagePath": './assets/images/twitter.png', "linkurl": ''},
    {"imagePath": './assets/images/telegram.png', "linkurl": ''},
    {"imagePath": './assets/images/facebook.png', "linkurl": ''},
    {"imagePath": './assets/images/whatsapp.png', "linkurl": ''},
    {"imagePath": './assets/images/email.png', "linkurl": ''},
    {"imagePath": './assets/images/site.png', "linkurl": ''},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.title == 'حول التطبيق') {
      _showLinks = true;
      htmlPath = 'assets/about/about.html';
    } else if (widget.title == 'ارشادات') {
      htmlPath = 'assets/about/sayings.html';
    }
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(widget.title),
      body: Center(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: WebView(
                onWebViewCreated: (WebViewController controller) {
                  controller.loadFlutterAsset(htmlPath);
                  _controller.complete(controller);
                },
                onWebResourceError: (error) {
                  debugPrint(error.toString());
                },
                gestureNavigationEnabled: true,
                geolocationEnabled: true,
                zoomEnabled: false,
                javascriptMode: JavascriptMode.unrestricted,
                navigationDelegate: (navigation) {
                  if (navigation.url.contains("mailto:")) {
                    _launchUrl(navigation.url);
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            ),
            Visibility(
              visible: _showLinks,
              child: Positioned(
                bottom: 0,
                child: Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      for (final item in _Links)
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                          ),
                          child: switch (item) {
                            {
                              'imagePath': final String imagePath,
                              'linkurl': final String linkurl,
                            } =>
                              GestureDetector(
                                onTap: () {
                                  debugPrint(linkurl.toString());
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  width: size.width / _Links.length,
                                  child: Image.asset(
                                    imagePath,
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
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
