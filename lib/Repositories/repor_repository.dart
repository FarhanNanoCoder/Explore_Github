import 'dart:convert';

import 'package:explore_github/Models/api_response.dart';
import 'package:explore_github/Models/repo.dart';
import 'package:explore_github/Providers/repo_provider.dart';
import 'package:explore_github/Repositories/Local/local_repo_repository.dart';
import 'package:explore_github/Repositories/api_constants.dart';
import 'package:explore_github/Utilities/environment.dart';
import 'package:explore_github/Utilities/utility.dart';
import 'package:http/http.dart' as http;

class RepoRepository {
  static Future<APIResponse<List<Repo>>> getAllRepos(
      {String? query,
      String? sort,
      String? order,
      int? page,
      int? perPage}) async {
    if (!await Utility.isInternetConnected()) {
      return LocalReporepository.getAllRepos();
    }

    RepoProvider().setLoader(true);
        var params = <String, String>{};
    if (query != null) {
      params["q"] = query??"";
    }
    if (sort != null && sort.isNotEmpty) {
      params["sort"] = sort;
    }
    if (order != null && order.isNotEmpty) {
      params["order"] = order;
    }
    if (page != null && page!.toString().isNotEmpty) {
      params["page"] = page!.toString();
    }
    if (perPage != null && perPage!.toString().isNotEmpty) {
      params["per_page"] = perPage!.toString();
    }

    Uri url = Uri(
        scheme: "https",
        host: Environment.baseGithubDomain,
        path: "/search/repositories",
        queryParameters: params);

    print(url.toString());

    return http.get(url, headers: headers).then((data) async {
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      
      final jsonData = json.decode(responseData);
      if (jsonData != null) {
        final List<Repo> repos = jsonData["items"]
            ?.map<Repo>((e) => Repo.fromJson(e))
            .toList()??[];
        await LocalReporepository.saveAllRepos(responseData);

        RepoProvider().setLoader(false);
        return APIResponse<List<Repo>>(data: repos);
      }
      RepoProvider().setLoader(false);
      return APIResponse<List<Repo>>(
          error: true, message: "An error occurred");
    }).catchError((_) {
      RepoProvider().setLoader(false);
      return APIResponse<List<Repo>>(
          error: true, message: "An error occurred");
    });
  }

  static Future<APIResponse<Repo>> getRepoDetails(int? repoId)async{
    if (!await Utility.isInternetConnected()) {
      return APIResponse<Repo>(error: true, message: "No internet connection");
    }
    RepoProvider().setLoader(true);
    Uri url = Uri(
        scheme: "https",
        host: Environment.baseGithubDomain,
        path: "/repositories/$repoId");

    print(url.toString());

    return http.get(url, headers: headers).then((data) async {
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      
      final jsonData = json.decode(responseData);
      if (jsonData != null) {
        final Repo repo = Repo.fromJson(jsonData);
        RepoProvider().setLoader(false);
        return APIResponse<Repo>(data: repo);
      }
      RepoProvider().setLoader(false);
      return APIResponse<Repo>(
          error: true, message: "An error occurred");
    }).catchError((_) {
      RepoProvider().setLoader(false);
      return APIResponse<Repo>(
          error: true, message: "An error occurred");
    });
  }
}
