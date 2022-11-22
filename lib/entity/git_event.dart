// To parse this JSON data, do
//
//     final gitEvent = gitEventFromJson(jsonString);

import 'dart:convert';

List<GitEvent> gitEventFromJson(String str) => List<GitEvent>.from(json.decode(str).map((x) => GitEvent.fromJson(x)));

String gitEventToJson(List<GitEvent> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GitEvent {
  GitEvent({
    this.id,
    this.type,
    this.actor,
    this.repo,
    this.payload,
    this.public,
    this.createdAt,
    this.org,
  });

  String? id;
  String? type;
  Actor? actor;
  Repo? repo;
  Payload? payload;
  bool? public;
  DateTime? createdAt;
  Actor? org;

  factory GitEvent.fromJson(Map<String, dynamic> json) => GitEvent(
    id: json["id"],
    type: json["type"],
    actor: Actor.fromJson(json["actor"]),
    repo: Repo.fromJson(json["repo"]),
    payload: Payload.fromJson(json["payload"]),
    public: json["public"],
    createdAt: DateTime.parse(json["created_at"]),
    org: json["org"] == null ? null : Actor.fromJson(json["org"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "actor": actor?.toJson(),
    "repo": repo?.toJson(),
    "payload": payload?.toJson(),
    "public": public,
    "created_at": createdAt?.toIso8601String(),
    "org": org == null ? null : org?.toJson(),
  };
}

class Actor {
  Actor({
    this.id,
    this.login,
    this.displayLogin,
    this.gravatarId,
    this.url,
    this.avatarUrl,
  });

  int? id;
  String? login;
  String? displayLogin;
  String? gravatarId;
  String? url;
  String? avatarUrl;

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
    id: json["id"],
    login: json["login"],
    displayLogin: json["display_login"] == null ? null : json["display_login"],
    gravatarId: json["gravatar_id"],
    url: json["url"],
    avatarUrl: json["avatar_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "login": login,
    "display_login": displayLogin == null ? null : displayLogin,
    "gravatar_id": gravatarId,
    "url": url,
    "avatar_url": avatarUrl,
  };
}

class Payload {
  Payload({
    this.pushId,
    this.size,
    this.distinctSize,
    this.ref,
    this.head,
    this.before,
    this.commits,
    this.refType,
    this.masterBranch,
    this.description,
    this.pusherType,
  });

  int? pushId;
  int? size;
  int? distinctSize;
  String? ref;
  String? head;
  String? before;
  List<Commit>? commits;
  String? refType;
  String? masterBranch;
  dynamic? description;
  String? pusherType;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    pushId: json["push_id"] == null ? null : json["push_id"],
    size: json["size"] == null ? null : json["size"],
    distinctSize: json["distinct_size"] == null ? null : json["distinct_size"],
    ref: json["ref"] == null ? null : json["ref"],
    head: json["head"] == null ? null : json["head"],
    before: json["before"] == null ? null : json["before"],
    commits: json["commits"] == null ? null : List<Commit>.from(json["commits"].map((x) => Commit.fromJson(x))),
    refType: json["ref_type"] == null ? null : json["ref_type"],
    masterBranch: json["master_branch"] == null ? null : json["master_branch"],
    description: json["description"],
    pusherType: json["pusher_type"] == null ? null : json["pusher_type"],
  );

  Map<String, dynamic> toJson() => {
    "push_id": pushId == null ? null : pushId,
    "size": size == null ? null : size,
    "distinct_size": distinctSize == null ? null : distinctSize,
    "ref": ref == null ? null : ref,
    "head": head == null ? null : head,
    "before": before == null ? null : before,
    "commits": commits == null ? null : List<dynamic>.from(commits!.map((x) => x.toJson())),
    "ref_type": refType == null ? null : refType,
    "master_branch": masterBranch == null ? null : masterBranch,
    "description": description,
    "pusher_type": pusherType == null ? null : pusherType,
  };
}

class Commit {
  Commit({
    this.sha,
    this.author,
    this.message,
    this.distinct,
    this.url,
  });

  String? sha;
  Author? author;
  String? message;
  bool? distinct;
  String? url;

  factory Commit.fromJson(Map<String, dynamic> json) => Commit(
    sha: json["sha"],
    author: Author.fromJson(json["author"]),
    message: json["message"],
    distinct: json["distinct"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "sha": sha,
    "author": author?.toJson(),
    "message": message,
    "distinct": distinct,
    "url": url,
  };
}

class Author {
  Author({
    this.email,
    this.name,
  });

  String? email;
  String? name;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    email: json["email"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "name": name,
  };
}

class Repo {
  Repo({
    this.id = 0,
    this.name,
    this.url,
  });

  int? id;
  String? name;
  String? url;

  factory Repo.fromJson(Map<String, dynamic> json) => Repo(
    id: json["id"],
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
  };
}
