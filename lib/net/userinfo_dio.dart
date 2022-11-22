import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:gsy_github_flutter_follow/common/share_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entity/git_userinfo.dart';
import 'address.dart';

class UserinfoDio {
  static Future<GitUserInfo> requestUserInfo(String token) async {
    Dio dio = new Dio();
    String url = Address.getMyUserInfo();

    dio.options.contentType = "application/json";
    dio.options.contentType = "application/json";

    ///请求header的配置
    dio.options.headers["Authorization"] = "token " + token;

    Response response = await dio.get(url);
    GitUserInfo gitUserInfo = GitUserInfo.fromJson(response.data);
    print("gsy userinfo login =" + gitUserInfo.login.toString());
    return gitUserInfo;
  }
}
