import 'package:explore_github/Utilities/app_text.dart';
import 'package:explore_github/Views/Components/Core/app_button.dart';
import 'package:explore_github/Views/Screens/Entrance/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EntranceScreen extends StatelessWidget {
  static const routeName = '/EntranceScreen';

  const EntranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:  SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 56, ),
              SvgPicture.asset("assets/images/welcome.svg", width: MediaQuery.of(context).size.width * .7,),
              const SizedBox(height: 44,),
              AppText(text: "Explore Github", style: 'bold', size: 36).getText(),
              const SizedBox(height: 44, ),
              AppButton(context: context).getTextButton(
                  title: "Login",
                  onPressed: () {
                    Navigator.pushNamed(context, AuthScreen.routeName, arguments: true);
                  }),
              const SizedBox(height: 16,),
              AppButton(context: context).getTextButton(
                  title: "Register",
                  onPressed: () {
                    Navigator.pushNamed(context, AuthScreen.routeName, arguments:false);
                  }),
            ],
          )
        )
      ),
    );
  }
}