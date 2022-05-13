import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gram_villa_latest/Constants.dart';
import 'package:gram_villa_latest/styles/colors.dart';
import 'package:gram_villa_latest/widgets/app_text.dart';

class SearchBarWidget extends StatelessWidget {
  final String searchIcon = "assets/icons/search_icon.svg";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Color(0xffF8A44C).withOpacity(0.4),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
            child: AppText(
              text: "What would you like to order?",
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              fontSize: 22,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(borderRadius * 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  searchIcon,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Search Store",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
