import 'package:explore_github/Utilities/app_colors.dart';
import 'package:explore_github/Views/Components/Core/flow_navigationbar.dart';
import 'package:explore_github/Views/Screens/Dashboard/dashboard_screen.dart';
import 'package:explore_github/Views/Screens/Settings/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = "/HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors().white,
        body: PageView(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
          onPageChanged: (position) {
            setState(() {
              currentIndex = position;
              //print(currentIndex);
            });
          },
          children: [
            DashboardScreen(),
        
            SettingsScreen(),
          ],
        ),
        bottomNavigationBar: FlowNavigationBar(
          initialIndex: currentIndex,
          activeIconColor: AppColors().white,
          onIndexChangedListener: (index) {
            setState(() {
              currentIndex = index;
              _controller.animateToPage(currentIndex,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
              //print(currentIndex);
            });
          },
          icons: const [
            Icons.dashboard_outlined,
            // Icons.circle_outlined,
            // Icons.history_outlined,
            Icons.settings_outlined,
          ],
        ),
      ),
    );
  }
}