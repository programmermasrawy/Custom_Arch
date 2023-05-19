import 'dart:io';

import 'package:Goat/core/services/loader.dart';
import 'package:Goat/core/view/widgets/app_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key, required this.url}) : super(key: key);
  final String url;

  static const id = "web-view-screen";

  @override
  State<StatefulWidget> createState() {
    return WebViewScreenState();
  }
}

class WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  bool buttonshow = false;

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      appBar: AppBar(
        title: const Text('Flutter WebView'),
      ),
      floatingActionButton: Visibility(
        visible: buttonshow,
        child: FloatingActionButton(
          onPressed: () {
            scrollToTop();
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.navigation),
        ),
      ),
      child: WebView(
        initialUrl: widget.url.isNotEmpty ? widget.url : 'https://flutter.dev',
        javascriptMode: JavascriptMode.unrestricted,
        allowsInlineMediaPlayback: true,
        gestureNavigationEnabled: true,
        onPageFinished: (String url) {
          Navigator.pop(context);
        },
        onPageStarted: (String url) {},
        onProgress: (int progress) {
          Loader.instance.show(context);
        },
          gestureRecognizers: Set()
            ..add(
                Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer()
                  ..onDown = (tap) {
                    floatingButtonVisibility();
                  }))

      ),
    );
  }
  void scrollToTop(){
    _controller.runJavascript("window.scrollTo({top: 0, behavior: 'smooth'});");
    floatingButtonVisibility();
  }

  void floatingButtonVisibility() async {
    int y = await  _controller.getScrollY();
    if(y>50){
      setState(() {
        buttonshow = true;
      });
    }else {
      setState(() {
        buttonshow = false;
      });
    }
  }
}
