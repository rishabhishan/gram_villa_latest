import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gram_villa_latest/dao/cart_dao.dart';
import 'package:gram_villa_latest/dao/product_dao.dart';
import 'package:gram_villa_latest/screens/dashboard/dashboard_screen.dart';
import 'package:gram_villa_latest/screens/welcome_screen.dart';
import 'package:gram_villa_latest/service/auth_service.dart';
import 'package:gram_villa_latest/styles/colors.dart';
import 'package:gram_villa_latest/styles/theme.dart';
import 'package:provider/provider.dart';

import '../Constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    const delay = const Duration(seconds: 2);
    Future.delayed(delay, () => onTimerFinished());
  }

  Future<void> onTimerFinished() async {
    bool userLogggedIn = await AuthService().isLoggedIn();

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthService>(
              lazy: false,
              create: (_) => AuthService(),
            ),
            ChangeNotifierProvider(create: (_) => CartDao()),
            Provider(create: (_) => ProductDao()),
          ],
          child: MaterialApp(
            theme: themeData,
            title: 'GramVilla',
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: <String, WidgetBuilder>{
              '/landing': (BuildContext context) => DashboardScreen(),
              '/home': (BuildContext context) => SplashScreen()
            },
            home: Consumer<AuthService>(
              builder: (context, authService, child) {
                if (userLogggedIn) {
                  authService.refreshLastSeen();
                  return DashboardScreen();
                } else {
                  return WelcomeScreen();
                }
              },
            ),
          ),
        );
        ;
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackGroundColor,
      body: Center(
        child: splashScreenIcon(),
      ),
    );
  }
}

Widget splashScreenIcon() {
  return SvgPicture.asset(
    splashIconPath,
  );
}
