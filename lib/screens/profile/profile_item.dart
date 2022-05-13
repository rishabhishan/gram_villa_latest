import 'package:flutter/material.dart';
import 'package:gram_villa_latest/screens/orders/orders_screen.dart';

class ProfileItem {
  final String label;
  final String iconPath;
  final Widget screen;

  ProfileItem(this.label, this.iconPath, this.screen);
}

List<ProfileItem> profileItems = [
  ProfileItem("Orders", "assets/icons/account_icons/orders_icon.svg", OrdersScreen()),
  ProfileItem("Help", "assets/icons/account_icons/help_icon.svg", OrdersScreen()),
];
