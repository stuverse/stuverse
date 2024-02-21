import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, required this.url});
  final String url;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  bool isLoading = true;
  double currentProgress = 0;

  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // print the loading progress to the console
            // you can use this value to show a progress bar if you want
            debugPrint("Loading: $progress%");
            setState(() {
              currentProgress = progress * 0.01;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView'),
      ),
      body: SafeArea(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    value: currentProgress,
                  ),
                )
              : WebViewWidget(
                  controller: _controller,
                )),
    );
  }
}
