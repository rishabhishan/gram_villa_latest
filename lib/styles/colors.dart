import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  //One instance, needs factory
  static final AppColors _appColors = AppColors._internal();
  factory AppColors() {
    return _appColors;
  }
  AppColors._internal();

  static const Color primaryColor = Color(0xff1f2633);
  static const darkGrey = Color(0xff7C7C7C);
  static const secondaryColor = Color(0xffff6047);


  static const splashBackGroundColor = primaryColor;
}
