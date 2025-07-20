import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ministry/constants/appbar.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:ministry/constants/constants.dart';
import 'package:ministry/db/database.dart';

class SendComplaintPage extends StatefulWidget {
  const SendComplaintPage({super.key});

  @override
  State<SendComplaintPage> createState() => _SendComplaintPageState();
}

final Completer<WebViewController> _controller = Completer<WebViewController>();
late final WebViewController _webViewController;

class _SendComplaintPageState extends State<SendComplaintPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('ارسال شكوى'),
      body: WebView(
        initialUrl: 'https://ca.moelc.gov.iq/embed',
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: true,
        geolocationEnabled: true,
        onPageFinished: (url) {
          _webViewController
              .runJavascript("setFirebaseToken('${Constants.userToken}')");
        },
        onWebViewCreated: (WebViewController controller) {
          _controller.complete(controller);
          _webViewController = controller;
        },
        javascriptChannels: <JavascriptChannel>{
          JavascriptChannel(
            name: 'SaveTrackingId',
            onMessageReceived: (JavascriptMessage message) {
              print(message.message);
              saveTrackingId(message.message);
            },
          ),
        },
      ),
    );
  }
}
