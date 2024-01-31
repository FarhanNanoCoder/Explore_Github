import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  Color primaryColor = const Color(0xFF1F2544);
  Color secondaryColor = const Color(0xFFE5AC77);
  Color white = const Color(0xFFFFFFFF);
  Color textColor = const Color(0xFF1F2544);
  Color white70 = Colors.white70;
  Color red = Colors.redAccent;

  Color grey100 = Colors.grey[100]!;
  Color grey200 = Colors.grey[200]!;
  Color grey300 = Colors.grey[300]!;
  Color grey400 = Colors.grey[400]!;
  Color grey600 = Colors.grey[600]!;
  Color grey900 = Colors.grey[900]!;

  static final AppColors _instance = AppColors._internal();
  factory AppColors() {
    return _instance;
  }
  AppColors._internal();
}
