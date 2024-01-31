import 'dart:io';

import 'package:explore_github/Utilities/app_colors.dart';
import 'package:explore_github/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Utility {
  static get context => RootApp.navKey.currentContext!;
  static pop() => Navigator.of(context).pop();

  static Future<bool> isInternetConnected() async {
    try {
      if (kIsWeb) {
        return true;
      }

      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }

  static showSnackBar(String value,
      {Function()? onRetry,
      int durationInSeconds = 2,
      Color color = const Color(0xFF1F2544)}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: durationInSeconds),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      padding: onRetry == null
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.only(left: 12),
      behavior: SnackBarBehavior.floating,
      content: Text(
        value,
        style: const TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
      ),
      backgroundColor: color,
      action: onRetry == null
          ? null
          : SnackBarAction(
              label: 'Retry',
              textColor: Colors.white60,
              onPressed: onRetry,
            ),
    ));
  }
}
