import 'package:flutter/material.dart';
import 'package:gsy_github_flutter_follow/page/login_web_page.dart';

import 'net/address.dart';


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
        appBar: AppBar(
          title: Text("login page"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "注册时填写的用户名或邮箱",
                  prefixIcon: Icon(Icons.person),
                ),
                controller: nameController,
              ),
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "登录密码",
                  prefixIcon: Icon(Icons.person),
                ),
                controller: pwdController,
                obscureText: true,
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
      ),
    );
  }

  Future goWebviewRoute(){
     return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginWebPage(Address.getOAuthUrl(), "webview")),
    );


  }

  authLogin() async{
    String code = await goWebviewRoute();
    print("gsy code = " + code);
  }





}
