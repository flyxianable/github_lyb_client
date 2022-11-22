import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gsy_github_flutter_follow/common/share_names.dart';
import 'package:gsy_github_flutter_follow/entity/git_event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'address.dart';

class GitDynamicDio {
  static Future<List<GitEvent>> requestGitDynamic(String userName, int page) async {
    Dio dio = Dio();
    String url =
        Address.getEventReceived(userName) + Address.getPageParams("?", page);

    dio.options.responseType = ResponseType.json;
    dio.options.contentType = "application/json";

    var prefes = await SharedPreferences.getInstance();
    String? accessToken = prefes.getString(ShareNames.accessToken);
    print("gsy prefes dynamic accessToken = " + accessToken.toString());

    ///请求header的配置
    if (accessToken != null) {
      dio.options.headers["Authorization"] = "token " + accessToken.toString();
    }

    Response response = await dio.get(url);
    List<GitEvent> listEvent = [];
    List<dynamic> result = response.data;
    if(result == null || result.length == 0){
      return listEvent;
    }
    print("gsy dynamic result =" + result.toString());
    for(int i=0; i< result.length; i++){
      GitEvent event = GitEvent.fromJson(response.data[i]);
      listEvent.add(event);
      if (event != null &&
          event.actor != null &&
          event.actor?.url != null) {
        print("gsy dynamic event =" + i.toString() + " ~ " + event.actor!.url.toString());
      }
    }
    return listEvent;


  }
}
