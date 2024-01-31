import 'package:explore_github/Models/api_response.dart';
import 'package:explore_github/Repositories/auth_repository.dart';
import 'package:explore_github/Utilities/app_colors.dart';
import 'package:explore_github/Utilities/utility.dart';
import 'package:explore_github/Views/Components/Core/app_button.dart';
import 'package:explore_github/Views/Screens/Entrance/entrance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = "/SettingsScreen";

  void handleLogout() async {
    APIResponse<bool> res = await AuthRepository.signout();

    if (res.data != null) {
      //navigate to login screen
      Navigator.of(Utility.context)
          .pushNamedAndRemoveUntil(EntranceScreen.routeName, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors().white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/settings.svg",
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(height: 24,),
              AppButton(context: context).getOutlinedTextButtton(
                  title: "Logout", onPressed: handleLogout)
            ],
          ),
        ),
      ),
    );
  }
}
