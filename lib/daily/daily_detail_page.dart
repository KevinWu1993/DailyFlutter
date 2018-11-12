import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class DailyDetailPage extends StatefulWidget {
  DailyDetailPage({Key key, this.title, this.url}) : super(key: key);
  final String title;
  final String url;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<DailyDetailPage> {
//  bool loading = true;

//  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
//    flutterWebViewPlugin.onStateChanged.listen((state) {
//    });
//    flutterWebViewPlugin.onUrlChanged.listen((url) {
//      setState(() {
//        loading = false;
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        title: Text(widget.title),
      ),
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
//    flutterWebViewPlugin.dispose();
    super.dispose();
  }
}