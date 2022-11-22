import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gsy_github_flutter_follow/entity/git_event.dart';
import 'package:gsy_github_flutter_follow/net/git_dynamic_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/share_names.dart';
import '../entity/git_userinfo.dart';
import '../ui/loading.dart';

class DynamicPage extends StatefulWidget {
  String? title;

  DynamicPage(this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StateDynamic(title);
  }
}

class StateDynamic extends State<DynamicPage> {
  String? title;
  List<GitEvent>? listEvent;
  StateDynamic(this.title);
  bool isloading = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
            child: ListView.builder(
                itemCount: listEvent == null ? 0 : listEvent!.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildItem(listEvent![index]);
                }),
          ),
          if(isloading)
            Loading.buildSpinLoading(context)
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
                    padding: const EdgeInsets.only(left: 50),
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
    request();
  }

  request() async {
    List<GitEvent> result =
        await GitDynamicDio.requestGitDynamic("flyxianable", 1);
    setState(() {
      listEvent = result;
      isloading = false;
    });
  }
}
