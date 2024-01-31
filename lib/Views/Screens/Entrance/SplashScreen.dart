import 'package:explore_github/Utilities/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/SplashScreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@override void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if (FirebaseAuth.instance.currentUser != null) {
            Navigator.pushReplacementNamed(context, '/AuthScreen');
      } else {
        Navigator.pushReplacementNamed(context, '/AuthScreen');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: AppColors().secondaryColor,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors().primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
