// Add this import for Completer
import 'package:MouTracker/models/personalized_text.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewClass extends StatefulWidget {
  const WebViewClass({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  WebViewState createState() => WebViewState();
}

class WebViewState extends State<WebViewClass> {
  int position = 1;

  final key = UniqueKey();

  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PText(widget.url),
        centerTitle: true,
      ),
      body: IndexedStack(index: position, children: <Widget>[
        SafeArea(
          top: true,
          bottom: true,
          child: WebView(
            initialUrl: "https://${widget.url}",
            javascriptMode: JavascriptMode.unrestricted,
            key: key,
            onPageFinished: doneLoading,
            onPageStarted: startLoading,
          ),
        ),
        Container(
          color: Colors.white,
          child: const Center(child: CircularProgressIndicator()),
        ),
      ]),
    );
  }
}
