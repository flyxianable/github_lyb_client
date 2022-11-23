import 'package:flutter/material.dart';
import 'package:gsy_github_flutter_follow/page/dynamic_refreshindicator_page.dart';

import '../style/git_style.dart';
import 'dynamic_smart_refresh_page.dart';

class HomeBottomTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeState();
  }
}

class HomeState extends State<HomeBottomTabPage> with SingleTickerProviderStateMixin{
  int selectIdx = 0;
  List<Widget> widgets = [
    DynamicSmartRefreshPage("动态"),
    DynamicRefreshIndicatorPage("趋势"),
    DynamicRefreshIndicatorPage("我的"),
  ];
   PageController _pageController = new PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return
      // DefaultTabController(
      // length: 3,
      // child:
       Scaffold(
        appBar: AppBar(
          title: Text("github home"),
        ),
        // body: widgets.elementAt(selectIdx),
        body: PageView(
          children: widgets,
          controller: _pageController,
          onPageChanged: (index){
            setState(() {
              selectIdx = index;
            });
          },

        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectIdx,
          items: [
            _renderBarItem(GitStyle.MAIN_DYNIMIC, "home_dynamic"),
            _renderBarItem(GitStyle.MAIN_TREND, "home_trend"),
            _renderBarItem(GitStyle.MAIN_MY, "home_my"),
          ],
          onTap: (int index) {
            _pageController.jumpToPage(index);
            setState(() {
              selectIdx = index;
            });
          },
          // selectedItemColor: Colors.red,
          // unselectedItemColor: Colors.black,
        ),
      );
    // );
  }
}


_renderBarItem(icon, text) {
  return BottomNavigationBarItem(
    icon: Icon(icon, size: 16.0),
    label: text,
  );
}


