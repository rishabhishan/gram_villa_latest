import 'package:flutter/material.dart';
import 'package:gram_villa_latest/Constants.dart';
import 'package:gram_villa_latest/styles/colors.dart';
import 'package:gram_villa_latest/widgets/app_text.dart';

class HomeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blue,
      ),
      child:

      // Row(
      //   children: [
      //     Container(
      //       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      //       child: Image.asset(
      //         "assets/images/home_banner.png",
      //       ),
      //     ),
      //     Spacer(),
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         AppText(
      //           text: "Fresh Vegetables",
      //           fontSize: 18,
      //           fontWeight: FontWeight.bold,
      //         ),
      //         AppText(
      //           text: "Get Up To 40%  OFF",
      //           fontSize: 16,
      //           fontWeight: FontWeight.w600,
      //           color: AppColors.primaryColor,
      //         ),
      //       ],
      //     ),
      //     SizedBox(
      //       width: 20,
      //     )
      //   ],
      // ),
      Container(
        //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Image.asset(
          "assets/images/home_banner.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
