import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = "/DashboardScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
    );
  }
}
