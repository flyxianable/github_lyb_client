// To parse this JSON data, do
//
//     final gitLoginBean = gitLoginBeanFromJson(jsonString);

import 'dart:convert';

GitLoginBean gitLoginBeanFromJson(String str) => GitLoginBean.fromJson(json.decode(str));

String gitLoginBeanToJson(GitLoginBean data) => json.encode(data.toJson());

class GitLoginBean {
  GitLoginBean({
    this.accessToken,
    this.scope,
    this.tokenType,
  });


  String? accessToken;
  String? scope;
  String? tokenType;

  factory GitLoginBean.fromJson(Map<String, dynamic> json) => GitLoginBean(
    accessToken: json["access_token"],
    scope: json["scope"],
    tokenType: json["token_type"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "scope": scope,
    "token_type": tokenType,
  };
}
