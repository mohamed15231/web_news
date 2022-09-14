
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class ScreenWebView extends StatelessWidget {
  final String url;

  const ScreenWebView({super.key, required this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
