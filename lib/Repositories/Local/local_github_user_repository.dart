import 'dart:convert';

import 'package:explore_github/Models/api_response.dart';
import 'package:explore_github/Models/github_user.dart';
import 'package:hive/hive.dart';

class LocalGithubUserRepository {
  static Future<void> saveAllGithubUsers(String users) async {
    try {
      print("saving in local$users");
      final githubUserHive = await Hive.openBox('localData');
      await githubUserHive.put('githubUsers', users);
      // print("saved in local");
    } catch (e) {
      print(e);
    }
  }

  static Future<APIResponse<List<GithubUser>>> getAllGithubUsers() async {
    try {
      final githubUserHive = await Hive.openBox('localData');

      String res = githubUserHive.get('githubUsers') ?? [];
      print("getting from local$res");
      final jsonData = json.decode(res);
      final List<GithubUser> users = jsonData["items"]
              ?.map<GithubUser>((e) => GithubUser.fromJson(e))
              .toList() ??
          [];

      return APIResponse<List<GithubUser>>(data: users);
    } catch (e) {
      print(e);
      return APIResponse<List<GithubUser>>(error: true, message: e.toString());
    }
  }
}
