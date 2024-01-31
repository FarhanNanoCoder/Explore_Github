import 'package:explore_github/Models/extra.dart';
import 'package:explore_github/Models/repo.dart';
import 'package:flutter/material.dart';

class RepoProvider with ChangeNotifier {
  List<Repo> repos = [];
  bool loader = false;
  Repo? currentRepo;
  Pagination? pagination;

  void setLoader(bool value) {
    loader = value;
    notifyListeners();
  }

  void setRepos(List<Repo> value) {
    repos = value;
    notifyListeners();
  }

  void setCurrentRepo(Repo value) {
    currentRepo = value;
    notifyListeners();
  }

  void setPagination(Pagination value) {
    pagination = value;
    notifyListeners();
  }

  //singleton
  static final _repoProvider = RepoProvider._internal();
  factory RepoProvider() {
    return _repoProvider;
  }
  RepoProvider._internal();
}
