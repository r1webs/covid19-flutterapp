import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatefulWidget {
  @override
  NewsWebViewState createState() {
    return NewsWebViewState();
  }
}

class NewsWebViewState extends State<NewsWebView> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    final _key = UniqueKey();
    return Container(
      child: WebView(
        initialUrl: 'about:blank',
        key: _key,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
          _loadHtmlFromAssets();
        },
      )
    );
  }

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/twitter-widget.html');
    _controller.loadUrl(
        Uri.dataFromString(
            fileText,
            mimeType: 'text/html',
            encoding: Encoding.getByName('utf-8')
        ).toString()
    );
  }
}