import 'dart:io';

import 'package:explore_github/Providers/AuthProvider.dart';
import 'package:explore_github/Utilities/AppColors.dart';
import 'package:explore_github/Utilities/CustomPageRoute.dart';
import 'package:explore_github/Views/Screens/Entrance/AuthScreen.dart';
import 'package:explore_github/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'Views/Screens/Entrance/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env.dev");

  // if(Platform.isAndroid){
  //   await Firebase.initializeApp();
  // }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
    ],
    child: const AppStart(),
  ));
}

class AppStart extends StatelessWidget {
  const AppStart({super.key});

  @override
  Widget build(BuildContext context) {
    return const RootApp();
  }
}

class RootApp extends StatefulWidget {
  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return MaterialApp(
              title: 'Explore Github',
              navigatorKey: RootApp.navKey,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'Poppins',
                visualDensity: VisualDensity.adaptivePlatformDensity,
                primaryColor: AppColors().primaryColor,
                appBarTheme:  AppBarTheme(
                  iconTheme: IconThemeData(color: AppColors().primaryColor),
                  backgroundColor: AppColors().white,
                  elevation: 0,
                  titleTextStyle: TextStyle(
                    color: AppColors().primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              themeMode: ThemeMode.light,
              navigatorObservers: const [],
              initialRoute: SplashScreen.routeName,
              onGenerateRoute: (settings) {
                switch (settings.name) {
                  case SplashScreen.routeName:return CustomPageRoute(page: SplashScreen(), settings: settings);
                  case AuthScreen.routeName:return CustomPageRoute(page: AuthScreen(), settings: settings);
                }
                return null;
              },
            );
          },
        );
      },
    );
  }
}
