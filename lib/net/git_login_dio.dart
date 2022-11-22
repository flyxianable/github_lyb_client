import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:gsy_github_flutter_follow/entity/git_login_bean.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/share_names.dart';
import 'address.dart';

class GitLoginDio {
  static Future<GitLoginBean> dioGitLogin(String code) async {
    Dio dio = Dio();
    String url = Address.getLoginUrl(code);

    dio.options.responseType = ResponseType.json;
    dio.options.contentType = "application/json";

    // Options options = Options();
    // ///请求header的配置
    // options.contentType="application/json";

    // 发起请求
    Response response = await dio.post(url);
    final prefs = await SharedPreferences.getInstance();
    Uri uri = Uri.parse("gsy://oauth?" + response.data);
    var accessToken = uri.queryParameters["access_token"];
    var scope = uri.queryParameters["scope"];
    var token_type = uri.queryParameters["token_type"];
    print("gsy result =" + uri.toString());
    print("gsy response.data =" + response.data);
    prefs.setString(ShareNames.accessToken, accessToken.toString());
    GitLoginBean gitLoginBean = new GitLoginBean(
        accessToken: accessToken, scope: scope, tokenType: token_type);
    print("gsy gitLoginBean =" + gitLoginBean.accessToken.toString());
    return gitLoginBean;
  }
}
