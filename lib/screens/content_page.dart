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
  // late final WebViewController _webViewController = WebViewController();
  late final String htmlPath;

  @override
  void initState() {
    super.initState();
    if (widget.title == 'حول التطبيق') {
      htmlPath = 'assets/about/about.html';
    } else if (widget.title == 'ارشادات') {
      htmlPath = 'assets/about/sayings.html';
    }
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(widget.title),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
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
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
