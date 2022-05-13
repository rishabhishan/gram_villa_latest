import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gram_villa_latest/service/db_service.dart';

import '../../Constants.dart';

class SearchBarWidget extends StatelessWidget {
  final Function onSubmit;
  final String searchIcon = "assets/icons/search_icon.svg";

  SearchBarWidget(this.onSubmit);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   padding: EdgeInsets.all(16),
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(borderRadius * 2),
    //   ),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       SvgPicture.asset(
    //         searchIcon,
    //       ),
    //       SizedBox(
    //         width: 16,
    //       ),
    //       Text(
    //         "Search Store",
    //         style: TextStyle(
    //           fontSize: 16,
    //           fontWeight: FontWeight.w600,
    //         ),
    //       )
    //     ],
    //   ),
    // );

    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      //width: double.maxFinite,
      decoration: BoxDecoration(
        color: Color(0xFFF2F3F2),
        borderRadius: BorderRadius.circular(borderRadius * 2),
      ),
      child: TextField(
        //autofocus: true,
        onSubmitted: (String searchString) => onSubmit(searchString),
        style: TextStyle(
            fontSize: 16,
          fontWeight: FontWeight.w600,
            //color: Color(0xFF7C7C7C)
        ),
        decoration: InputDecoration(
          hintText: "Search Store",
          icon: SvgPicture.asset(searchIcon),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
