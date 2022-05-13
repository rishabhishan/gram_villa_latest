import 'package:flutter/material.dart';
import 'package:gram_villa_latest/styles/colors.dart';

class ShowSnackbar {

  static void showSnackbar(String text, GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey) {
    scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: AppColors.secondaryColor,
      duration: Duration(seconds: 3),
    ));
  }
}
