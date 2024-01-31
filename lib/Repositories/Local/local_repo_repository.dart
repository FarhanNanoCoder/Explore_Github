import 'dart:convert';

import 'package:explore_github/Models/api_response.dart';
import 'package:explore_github/Models/repo.dart';
import 'package:hive/hive.dart';

class LocalReporepository{
  static Future<void> saveAllRepos(String repos) async {
    try {
      print("saving in local$repos");
      final repoHive = await Hive.openBox('localData');
      await repoHive.put('repos', repos);
      // print("saved in local");
    } catch (e) {
      print(e);
    }
  }

  static Future<APIResponse<List<Repo>>> getAllRepos() async {
    try {
      final repoHive = await Hive.openBox('localData');

      String res = repoHive.get('repos') ?? [];
      print("getting from local$res");
      final jsonData = json.decode(res);
      final List<Repo> repos = jsonData["items"]
              ?.map<Repo>((e) => Repo.fromJson(e))
              .toList() ??
          [];

      return APIResponse<List<Repo>>(data: repos);
    } catch (e) {
      print(e);
      return APIResponse<List<Repo>>(error: true, message: e.toString());
    }
  }
}