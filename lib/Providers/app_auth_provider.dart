import 'package:explore_github/Models/app_user.dart';
import 'package:flutter/material.dart';

class AppAuthProvider with ChangeNotifier {
  bool loader = false;
  AppUser? appUser;

  void setLoader(bool value) {
    loader = value;
    notifyListeners();
  }

  void setAppUser(AppUser? user) {
    appUser = user;
    notifyListeners();
  }

  //singleton
  static final _authProvider = AppAuthProvider._internal();
  factory AppAuthProvider() {
    return _authProvider;
  }
  AppAuthProvider._internal();
}
