import 'package:explore_github/Models/github_user.dart';

class Repo {
  int? id;
  String? name;
  GithubUser? owner;
  String? description;
  String? htmlUrl;
  String? createdAt;
  String? updatedAt;
  String? pushedAt;
  int? forksCount;
  String? language;
  int? stargazersCount;
  int? watchersCount;

  Repo(
      {this.id,
      this.name,
      this.owner,
      this.description,
      this.htmlUrl,
      this.createdAt,
      this.updatedAt,
      this.pushedAt,
      this.forksCount,
      this.stargazersCount,
      this.watchersCount,
      this.language});

  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(
        id: json["id"],
        name: json["name"],
        owner: GithubUser.fromJson(json["owner"]),
        description: json["description"],
        htmlUrl: json["html_url"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        pushedAt: json["pushed_at"],
        forksCount: json["forks_count"],
        stargazersCount: json["stargazers_count"],
        watchersCount: json["watchers_count"],
        language: json["language"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["id"] = id;
    data["name"] = name;
    data["owner"] = owner!.toJson();
    data["description"] = description;
    data["html_url"] = htmlUrl;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["pushed_at"] = pushedAt;
    data["forks_count"] = forksCount;
    data["language"] = language;
    data["stargazers_count"] = stargazersCount;
    data["watchers_count"] = watchersCount;
    return data;
  }
}
