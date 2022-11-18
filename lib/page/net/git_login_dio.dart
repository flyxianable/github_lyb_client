import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:gsy_github_flutter_follow/entity/git_login_bean.dart';

import 'address.dart';

class GitLoginDio {


  static Future dioGitLogin(String code) async {

    Dio dio = Dio();
    String url = Address.getLoginUrl(code);

    dio.options.responseType = ResponseType.json;
    dio.options.contentType = "application/json";

    // Options options = Options();
    // ///请求header的配置
    // options.contentType="application/json";

    // 添加拦截器
    // dio.interceptors
    //   ..add(LogInterceptor(
    //     requestHeader: true,
    //     requestBody: true,
    //     responseHeader: true,
    //     responseBody: true,
    //   ));

    // 发起请求
    Response response = await dio.post(url);
    Uri uri = Uri.parse("gsy://oauth?" + response.data);
    var token = uri.queryParameters["access_token"];
    var scope = uri.queryParameters["scope"];
    var token_type = uri.queryParameters["token_type"];
    print("gsy result =" + uri.toString());
    print("gsy response.data =" + response.data);
    GitLoginBean gitLoginBean = new GitLoginBean(accessToken: token, scope: scope, tokenType: token_type);
    print("gsy gitLoginBean =" + gitLoginBean.accessToken.toString());

  }
}
