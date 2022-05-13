import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gram_villa_latest/dao/user_dao.dart';
import 'package:gram_villa_latest/service/auth_service.dart';
import 'package:gram_villa_latest/styles/colors.dart';
import 'package:gram_villa_latest/widgets/app_button.dart';
import 'package:gram_villa_latest/widgets/app_text.dart';
import 'package:gram_villa_latest/widgets/show_snackbar.dart';
import 'package:provider/provider.dart';

import 'dashboard/dashboard_screen.dart';
import 'loading_screen.dart';
import 'otp/phone_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final String imagePath = "assets/images/welcome_image.png";
  bool isLoading = false;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingScreen()
        : ScaffoldMessenger(
            key: scaffoldMessengerKey,
            child: Scaffold(
                backgroundColor: AppColors.primaryColor,
                body: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Spacer(),
                        icon(),
                        const SizedBox(
                          height: 20,
                        ),
                        welcomeTextWidget(),
                        const SizedBox(
                          height: 10,
                        ),
                        sloganText(),
                        const SizedBox(
                          height: 40,
                        ),
                        getButton(context),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                )),
          );
  }

  Widget icon() {
    String iconPath = "assets/icons/app_icon.svg";
    return SvgPicture.asset(
      iconPath,
      width: 48,
      height: 56,
    );
  }

  Widget welcomeTextWidget() {
    return Column(
      children: const [
        AppText(
          text: "Welcome",
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        AppText(
          text: "to our store",
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget sloganText() {
    return AppText(
      text: "It is just not fast but fresh as well",
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: const Color(0xffFCFCFC).withOpacity(0.7),
    );
  }

  Widget getButton(BuildContext context) {
    return AppButton(
      label: "Login With Google",
      fontWeight: FontWeight.w600,
      onPressed: () {
        onLoginClicked(context);
      },
    );
  }

  Future<void> onLoginClicked(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    var user =
        await Provider.of<AuthService>(context, listen: false).googleSignIn();

    if (user != null) {
      setState(() {
        isLoading = false;
      });

      if (user.phoneNumber != null &&
          await Provider.of<AuthService>(context, listen: false).isLoggedIn()) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return DashboardScreen();
          }),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return const VerifyPhoneScreen();
          }),
        );
      }
    } else {
      setState(() {
        isLoading = false;
      });
      ShowSnackbar.showSnackbar(
          "Something went wrong. Please try again", scaffoldMessengerKey);
    }
  }
}
