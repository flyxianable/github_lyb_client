import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsy_github_flutter_follow/page/login_web_page.dart';
import 'package:gsy_github_flutter_follow/page/route/page_route.dart';
import 'package:rive/rive.dart';

import 'login_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new WelcomeState();
  }
}

class WelcomeState extends State<WelcomePage> {
  String text = "";
  double fontSize = 76;
  var color = Colors.orange;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double size = 200;
    return Material(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Center(
              child: Image.asset('static/images/welcome.png'),
            ),
            Align(
              alignment: Alignment(0, 0.3),
              child: Text(
                text,
                style: TextStyle(color: color, fontSize: fontSize),
              ),
            ),
            Align(
                alignment: Alignment(0, 0.8),
                child: Container(
                    width: size,
                    height: size,
                    child: RiveAnimation.asset('static/file/launch.riv'))),
          ],
        ),
      ),
    );
  }

  //     Column(
  //   children: [
  //     Container(
  //       color: Colors.white,
  //       height: 500,
  //       width: 500,
  //       child: Center(
  //         child: Image.asset('static/images/welcome.png'),
  //       ),
  //     ),
  //     Text(
  //       text,
  //       style: TextStyle(color: color, fontSize: fontSize),
  //     ),
  //     new Container(
  //         width: size,
  //         height: size,
  //         child: RiveAnimation.asset('static/file/launch.riv'))
  //   ],
  // ),
  // ),

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    new Future.delayed(Duration(microseconds: 500), () {
      setState(() {
        text = "welcome";
        fontSize = 70;
        color = Colors.red;
      });
    });

    new Future.delayed(Duration(seconds: 1, microseconds: 500), () {
      setState(() {
        text = "GSYGithubApp";
        fontSize = 50;
        color = Colors.blue;
      });
    });

    new Future.delayed(Duration(seconds: 2, microseconds: 500), () {
      GitRoute.goLoginRoute(context);
    });

  }


}
