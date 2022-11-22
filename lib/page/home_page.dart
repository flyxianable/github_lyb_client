import 'package:flutter/material.dart';
import 'package:gsy_github_flutter_follow/page/dynamic_page.dart';

import '../style/git_style.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeState();
  }
}

class HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("github home"),
          bottom: TabBar(
            tabs: [
              _renderTab(GitStyle.MAIN_DYNIMIC, "home_dynamic"),
              _renderTab(GitStyle.MAIN_TREND, "home_trend"),
              _renderTab(GitStyle.MAIN_MY, "home_my"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DynamicPage("动态"),
            DynamicPage("趋势"),
            DynamicPage("我的"),
          ],

        ),
      ),
    );
  }
}

_renderTab(icon, text) {
  return new Tab(
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[new Icon(icon, size: 16.0), new Text(text)],
    ),
  );
}
