import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gsy_github_flutter_follow/page/ui/loading.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWebPage extends StatefulWidget {
  late String url;
  late String title;

  LoginWebPage(this.url, this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new WebState();
  }
}

class WebState extends State<LoginWebPage> {
  bool isloading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("webview logining"),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith("gsygithubapp://authed")) {
                var code = Uri.parse(request.url).queryParameters["code"];
                print("gsy" + "code ${code}");
                Navigator.of(context).pop(code);
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            onPageFinished: (String str) {
              setState(() {
                isloading = false;
              });
              // Loading.dismissEasyLoading();
            },
          ),
          if (isloading)
            Loading.buildSpinLoading(context)
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    // Loading.showEasyLoading();

  }

}
