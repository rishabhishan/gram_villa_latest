import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gram_villa_latest/dao/cart_dao.dart';
import 'package:gram_villa_latest/dao/product_dao.dart';
import 'package:gram_villa_latest/styles/colors.dart';
import 'package:provider/provider.dart';

import 'navigator_item.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    print("************* DashboardScreen initState -- started");
    super.initState();
    fetchAllProducts();
    fetchCartItems();
    print("************* DashboardScreen initState -- ended");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigatorItems[currentIndex].screen,
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black38.withOpacity(0.05),
                spreadRadius: 0,
                blurRadius: 37,
                offset: Offset(0, -12)),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          type: BottomNavigationBarType.shifting,
          items: navigatorItems.map((e) {
            return getNavigationBarItem(
                label: e.label, index: e.index, iconPath: e.iconPath);
          }).toList(),
        ),
      ),
    );
  }

  BottomNavigationBarItem getNavigationBarItem(
      {required String label, required String iconPath, required int index}) {
    Color iconColor = index == currentIndex
        ? AppColors.secondaryColor
        : AppColors.primaryColor;
    double size = index == currentIndex ? 22 : 18;
    return BottomNavigationBarItem(
      label: label,
      icon: SvgPicture.asset(
        iconPath,
        color: iconColor,
        height: size,
      ),
    );
  }

  void fetchAllProducts() {
    ProductDao productService = Provider.of<ProductDao>(context, listen: false);
    productService.loadProductItemsFromFirebase();
  }

  void fetchCartItems()  {
    CartDao cartDao = Provider.of<CartDao>(context, listen: false);
    cartDao.loadCartItemsFromFirebase(context);
  }
}
