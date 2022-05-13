import 'package:flutter/material.dart';
import 'package:gram_villa_latest/screens/cart/cart_screen.dart';
import 'package:gram_villa_latest/screens/home/home_screen.dart';
import 'package:gram_villa_latest/screens/loading_screen.dart';
import 'package:gram_villa_latest/screens/profile/profile_screen.dart';
import 'package:gram_villa_latest/screens/search/search_screen.dart';

class NavigatorItem {
  final String label;
  final String iconPath;
  final int index;
  final Widget screen;

  NavigatorItem(this.label, this.iconPath, this.index, this.screen);
}

List<NavigatorItem> navigatorItems = [
  NavigatorItem("Shop", "assets/icons/bottombar_icons/shop_icon.svg", 0, HomeScreen()),
  NavigatorItem("Explore", "assets/icons/bottombar_icons/explore_icon.svg", 1, SearchScreen()),
  NavigatorItem("Cart", "assets/icons/bottombar_icons/cart_icon.svg", 2, CartScreen()),
  NavigatorItem("Account", "assets/icons/bottombar_icons/account_icon.svg", 3, ProfileScreen()),
];
