import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gsy_github_flutter_follow/entity/git_event.dart';
import 'package:gsy_github_flutter_follow/net/git_dynamic_dio.dart';

import '../common/config/config.dart';
import '../ui/loading.dart';

class DynamicRefreshIndicatorPage extends StatefulWidget {
  String? title;

  DynamicRefreshIndicatorPage(this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StateDynamic(title);
  }
}

class StateDynamic extends State<DynamicRefreshIndicatorPage> {
  String? title;
  List<GitEvent>? listEvent;

  StateDynamic(this.title);

  bool isRefreshloading = true;
  bool isNextLoading = false;

  ScrollController scrollController = ScrollController();
  int page = 1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
          child: RefreshIndicator(

            onRefresh: () async {
              refresh();
            },
            child: ListView.builder(
              itemCount: listEvent == null ? 0 : listEvent!.length,
              itemBuilder: (BuildContext context, int index) {
                return buildItem(listEvent![index]);
              },
              controller: scrollController,
            ),
          ),
        ),
        if (isRefreshloading) Loading.buildSpinLoading(context),
        if (isNextLoading)
          Positioned(
            bottom: 20,
            child: Loading.buildSpinLoading(context),
          )
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
    scrollController.addListener(scrollListener);
  }

  scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      print('滑动到了最底部');
      setState(() {
        isRefreshloading = false;
        isNextLoading = true;
      });
      request(false);
    }
  }

  refresh(){
    request(true);
  }

  request(bool isRefresh) async {
    if (!isRefresh) {
      page++;
    }

    List<GitEvent> result =
        await GitDynamicDio.requestGitDynamic("flyxianable", page);
    /**
     * 下一页并且返回数据少于一页
     */
    if (!isRefresh && (result == null || result.length < Config.PAGE_SIZE)) {
      scrollController.removeListener(scrollListener);
    }
    setState(() {
      if (listEvent == null || isRefresh) {
        listEvent = <GitEvent>[];
      }
      listEvent?.addAll(result);
      setState(() {
        isRefreshloading = false;
        isNextLoading = false;
      });
    });
  }
}
