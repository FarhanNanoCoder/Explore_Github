import 'package:explore_github/Models/extra.dart';
import 'package:explore_github/Models/github_user.dart';
import 'package:flutter/material.dart';

class GithubUserProvider with ChangeNotifier{
  List<GithubUser> githubUsers = [];
  GithubUser? currentGithubUser;
  bool loader = false;
  Pagination? pagination;

  void setLoader(bool value){
    loader = value;
    notifyListeners();
  }

  void setGithubUsers(List<GithubUser> users){
    githubUsers = users;
    notifyListeners();
  }

  void setCurrentGithubUser(GithubUser? user){
    currentGithubUser = user;
    notifyListeners();
  }

  void setPagination(Pagination? pagination){
    this.pagination = pagination;
    notifyListeners();
  }

  static final _githubUserProvider = GithubUserProvider._internal();
  factory GithubUserProvider(){
    return _githubUserProvider;
  }
  GithubUserProvider._internal();
}