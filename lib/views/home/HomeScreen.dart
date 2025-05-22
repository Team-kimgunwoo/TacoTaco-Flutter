import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kakao Map")),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse("https://map.kakao.com"),
        ),
      ),
    );
  }
}