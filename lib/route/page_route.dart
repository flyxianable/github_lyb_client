import 'package:flutter/material.dart';
import 'package:gsy_github_flutter_follow/page/home_bottom_tab_page.dart';
import 'package:gsy_github_flutter_follow/page/home_toptab_page.dart';
import 'package:gsy_github_flutter_follow/page/login_web_page.dart';

import '../page/login_page.dart';
import '../page/welcome.dart';


class GitRoute {

  // static void goPage(BuildContext context, String routeName) {
  //   if (routeName == "login") {
  //     goLoginRoute(context);
  //   } else if (routeName == "welcome") {
  //     goWelcomeRoute(context);
  //   } else if (routeName == "home") {
  //     goHomeRoute(context);
  //   }
  // }

  static void goWelcomeRoute(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WelcomePage()),
    );
  }

  static void goLoginRoute(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  static Future goWebviewRoute(BuildContext context, String url, String title) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginWebPage(url, title)),
    );
  }

  static void goTopTabHomeRoute(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeTopTabPage()),
    );
  }

  static void goBottomTabHomeRoute(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeBottomTabPage()),
    );
  }
}
