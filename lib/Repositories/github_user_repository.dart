import 'dart:convert';

import 'package:explore_github/Models/api_response.dart';
import 'package:explore_github/Models/extra.dart';
import 'package:explore_github/Models/github_user.dart';
import 'package:explore_github/Providers/github_user_provider.dart';
import 'package:explore_github/Repositories/Local/local_github_user_repository.dart';
import 'package:explore_github/Repositories/api_constants.dart';
import 'package:explore_github/Utilities/environment.dart';
import 'package:explore_github/Utilities/utility.dart';
import 'package:http/http.dart' as http;

class GithubUserRepository {
  static Future<APIResponse<List<GithubUser>>> getAllGithubUsers(
      {String? query,
      String? sort,
      String? order,
      int? page,
      int? perPage}) async {


    if (!await Utility.isInternetConnected()) {
      return LocalGithubUserRepository.getAllGithubUsers();
    }
    GithubUserProvider().setLoader(true);

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
        path: "/search/users",
        queryParameters: params);

    print(url.toString());

    return http.get(url, headers: headers).then((data) async {
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = json.decode(responseData);
      if (jsonData != null) {
        final List<GithubUser> users = jsonData["items"]
            ?.map<GithubUser>((e) => GithubUser.fromJson(e))
            .toList()??[];
        await LocalGithubUserRepository.saveAllGithubUsers(responseData);

        GithubUserProvider().setPagination(Pagination(
            totalCount: jsonData["total_count"],
            order: order,
            page: page,
            perPage: perPage,
            sort: sort));

        GithubUserProvider().setLoader(false);

        return APIResponse<List<GithubUser>>(data: users);
      } else {
        return APIResponse<List<GithubUser>>(
            error: true, message: "Something went wrong");
      }
    });
  }

  static Future<APIResponse<GithubUser>> getGithubUserDetails(
      {required String username}) async {
    if (!await Utility.isInternetConnected()) {
      return APIResponse<GithubUser>(
          error: true, message: "Please check your internet connection");
    }
    GithubUserProvider().setLoader(true);

    Uri url = Uri(
        scheme: "https",
        host: Environment.baseGithubDomain,
        path: "/users/$username");

    print(url.toString());

    return http.get(url, headers: headers).then((data) async {
      print(data.body);
      final responseData = utf8.decode(data.bodyBytes);
      final jsonData = jsonDecode(responseData);
      if (jsonData != null) {
        final GithubUser user = GithubUser.fromJson(jsonData);
        GithubUserProvider().setCurrentGithubUser(user);
        GithubUserProvider().setLoader(false);
        return APIResponse<GithubUser>(data: user);
      } else {
        return APIResponse<GithubUser>(
            error: true, message: "Something went wrong");
      }
    });
  }
}
