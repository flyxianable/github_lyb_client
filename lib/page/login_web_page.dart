import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginWebPage extends StatefulWidget {
  late String url;
  late String title;

  LoginWebPage(this.url, this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new WebState();
    ;
  }
}

class WebState extends State<LoginWebPage> {
  bool isloading = true;

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
              EasyLoading.dismiss();
            },
          ),
          if (isloading) buildLoading()
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // EasyLoading.instance.backgroundColor = Colors.white;
    // EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.ring;
    // // EasyLoading.instance.indicatorColor = Colors.grey;
    // EasyLoading.instance.maskColor = Colors.blue.withOpacity(0.5);

    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5);


    EasyLoading.show();
  }

  Widget buildLoading() {
    return Center(
      child: Text(
        "loading",
        style: TextStyle(fontSize: 36, color: Colors.blue),
      ),
    );
  }
}
