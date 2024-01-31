import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier{
  bool loader = false;

  void setLoader(bool value){
    loader = value;
    notifyListeners();
  }


  
  static final _userProvider = UserProvider._internal();
  factory UserProvider(){
    return _userProvider;
  }
  UserProvider._internal();
}