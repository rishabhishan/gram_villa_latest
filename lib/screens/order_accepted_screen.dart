import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gram_villa_latest/Constants.dart';
import 'package:gram_villa_latest/widgets/app_button.dart';

class OrderAcceptedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      insetPadding: EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        width: double.maxFinite,
        padding: paddingScreen,
        height: 600.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 30,
                  ),
                ),
              ],
            ),
            Spacer(
              flex: 8,
            ),
            SvgPicture.asset("assets/images/order_accepted_icon.svg"),
            Spacer(
              flex: 8,
            ),
            Text(
              "You Order Has Been Accepted",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Spacer(
              flex: 2,
            ),
            Text(
              "Your order has been placed and is on it's way to being processed",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff7C7C7C),
                  fontWeight: FontWeight.w600),
            ),
            Spacer(
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }
}
