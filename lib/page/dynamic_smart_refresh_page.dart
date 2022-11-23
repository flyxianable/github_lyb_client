import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsy_github_flutter_follow/entity/git_event.dart';
import 'package:gsy_github_flutter_follow/net/git_dynamic_dio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../common/config/config.dart';
import '../ui/loading.dart';

class DynamicSmartRefreshPage extends StatefulWidget {
  String? title;

  DynamicSmartRefreshPage(this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StateDynamic(title);
  }
}

class StateDynamic extends State<DynamicSmartRefreshPage> {
  String? title;
  List<GitEvent>? listEvent;

  bool isRefreshloading = true;
  int page = 1;
  String idleText = "下拉加载";
  bool haveNextPage = true;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  StateDynamic(this.title);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: haveNextPage,
            header: WaterDropHeader(),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                Widget? body;
                if (mode == LoadStatus.idle) {
                  body = Text(idleText);
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("松开加载更多");
                } else if (mode == LoadStatus.failed) {
                  body = Text("加载失败");
                } else if (mode == LoadStatus.loading) {
                  body = CupertinoActivityIndicator();
                }
                return Container(
                  alignment: Alignment.bottomCenter,
                  height: 55,
                  child: body,
                );
              },
            ),
            controller: _refreshController,
            onRefresh: () {
              print("gsy : onRefresh()");
              request(false);
            },
            onLoading: () {
              if (haveNextPage) {
                print("gsy : onLoading()");
                request(false);
              }
            },
            child: ListView.builder(
              itemCount: listEvent == null ? 0 : listEvent!.length,
              itemBuilder: (BuildContext context, int index) {
                return buildItem(listEvent![index]);
              },
            ),
          ),
        ),
        if (isRefreshloading) Loading.buildSpinLoading(context),
      ],
    );
  }

  buildItem(GitEvent gitEvent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage(gitEvent.actor!.avatarUrl.toString()),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(gitEvent.actor!.displayLogin.toString())),
              Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(gitEvent.createdAt.toString())),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    request(true);
  }

  refresh() {
    request(true);
  }

  request(bool isRefresh) async {
    if (!isRefresh) {
      page++;
    }

    List<GitEvent> result =
        await GitDynamicDio.requestGitDynamic("flyxianable", page);

    _refreshController.loadComplete();
    _refreshController.refreshCompleted();

    if (listEvent == null || isRefresh) {
      setState(() {
        listEvent = <GitEvent>[];
      });
    }
    if (!isRefresh && (result == null || result?.length == 0)) {
      setState(() {
        haveNextPage = false;
        idleText = "没有更多了";
      });
    }
    setState(() {
      listEvent?.addAll(result);
      isRefreshloading = false;
    });
  }
}
