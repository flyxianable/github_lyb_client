import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gsy_github_flutter_follow/common/share_names.dart';
import 'package:gsy_github_flutter_follow/entity/git_login_bean.dart';
import 'package:gsy_github_flutter_follow/page/login_web_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ani/ani_background.dart';
import '../entity/git_userinfo.dart';
import '../net/address.dart';
import '../net/git_login_dio.dart';
import '../net/userinfo_dio.dart';
import '../route/page_route.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _LoginState();
  }
}

class _LoginState extends State<LoginPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text("login page"),
        // ),
        body: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              AniBackground.buildAniWidget(),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20, right: 20, bottom: 200),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 20, bottom: 20),
                        labelText: "用户名",
                        hintText: "注册时填写的用户名或邮箱",
                        prefixIcon: Icon(Icons.person),
                      ),
                      controller: nameController,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 20, bottom: 20),
                          labelText: "密码",
                          hintText: "登录密码",
                          prefixIcon: Icon(Icons.keyboard),
                        ),
                        controller: pwdController,
                        obscureText: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: ElevatedButton(
                        onPressed: () {
                          authLogin();
                        },
                        child: Text("webview登录"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  authLogin() async {
    String code = await GitRoute.goWebviewRoute(
        context, Address.getOAuthUrl(), "webview");

    print("gsy code = " + code);
    GitLoginBean gitLoginBean = await GitLoginDio.dioGitLogin(code);
    if (gitLoginBean.accessToken != null) {
      GitUserInfo gitUserInfo =
          await UserinfoDio.requestUserInfo(gitLoginBean.accessToken!);
      print("gsy gitUserInfo.login = " + gitUserInfo.login.toString());
      if (gitUserInfo != null && gitUserInfo.login != null) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(ShareNames.userName, gitUserInfo.login.toString());
        GitRoute.goHomeRoute(context);
      }
    }
  }
}
