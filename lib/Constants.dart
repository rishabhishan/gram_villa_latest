import 'package:flutter/material.dart';
import 'package:gram_villa_latest/screens/helpers/size_config.dart';

const double curvedButtonHeight = 50.0;
const double curvedButtonBorder = 50.0;
const double borderRadius = 20.0;
const String DEFAULT_DIALING_CODE = "+91";
const String DEFAULT_PAYMENT_MODE = "COD";



const kTitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 26.0,
  height: 1.5,
);

const kSubtitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  height: 1.2,
);

// Colors
//const kTextColor = Colors.black;
const kBlueColor = Color(0xFF6E8AFA);
const kBestSellerColor = Color(0xFFFFD073);
const kGreenColor = Color(0xFF49CC96);

// My Text Styles
const kHeadingextStyle = TextStyle(
  fontSize: 24,
  color: kTextColor,
  fontWeight: FontWeight.w400,
);
const kSubheadingextStyle = TextStyle(
  fontSize: 18,
  color: Color(0xFF61688B),
  height: 2,
);

const kTitleTextStyle = TextStyle(
  fontSize: 20,
  color: kTextColor,
  fontWeight: FontWeight.bold,
);

const kSubtitleTextSyule = TextStyle(
  fontSize: 18,
  color: kTextColor,
  // fontWeight: FontWeight.bold,
);

//const kBackgroundColor = Color(0xFFF8F8F8);
const kActiveIconColor = Color(0xFFE68342);
const kBlueLightColor = Color(0xFFC7B8F5);
const kBlackColor = Color(0xFF393939);
const kLightBlackColor = Color(0xFF8F8F8F);
const kIconColor = Color(0xFFF48A37);
const kProgressIndicator = Color(0xFFBE7066);
const buttonBorderRadius = 5.0;
const posterBorderRadius = 5.0;
const buttonTextColor = Colors.white;
const heightButton = 60.0;
const heightButtonInPage = 50.0;



const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}



EdgeInsets buttonPadding =  EdgeInsets.symmetric(vertical: 20, horizontal: 30);
const EdgeInsets paddingScreen =  EdgeInsets.all(25.0);

String splashIconPath = "assets/icons/splash_screen_icon.svg";

