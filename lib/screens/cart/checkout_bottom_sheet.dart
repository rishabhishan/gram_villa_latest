import 'package:flutter/material.dart';
import 'package:gram_villa_latest/dao/cart_dao.dart';
import 'package:gram_villa_latest/models/order.dart';
import 'package:gram_villa_latest/service/db_service.dart';
import 'package:gram_villa_latest/widgets/app_button.dart';
import 'package:gram_villa_latest/widgets/app_text.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
import '../order_accepted_screen.dart';
import '../order_failed_dialog.dart';

class CheckoutBottomSheet extends StatefulWidget {
  final Order order;

  CheckoutBottomSheet(this.order, {Key? key}) : super(key: key);

  @override
  _CheckoutBottomSheetState createState() => _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 30,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: new Wrap(
        children: <Widget>[
          Row(
            children: [
              AppText(
                text: "Checkout",
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 25,
                  ))
            ],
          ),
          SizedBox(
            height: 45,
          ),
          getDivider(),
          checkoutRow("Delivery Slot", trailingText: "Tomorrow"),
          getDivider(),
          checkoutRow("Delivery Address", trailingText: widget.order.deliveryAddress!.getDisplayAddressShort()),
          getDivider(),
          checkoutRow("Payment", trailingText: widget.order.paymentMode),
          getDivider(),
          checkoutRow("Total Cost",
              trailingText: "Rs " + widget.order.billAmount.toStringAsFixed(0)),
          getDivider(),
          SizedBox(
            height: 30,
          ),
          termsAndConditionsAgreement(context),
          Container(
            margin: EdgeInsets.only(
              top: 25,
            ),
            child: AppButton(
              label: "Place Order",
              fontWeight: FontWeight.w600,
              padding: EdgeInsets.symmetric(
                vertical: 25,
              ),
              onPressed: () {
                onPlaceOrderClicked();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getDivider() {
    return Divider(
      thickness: 1,
      color: Color(0xFFE2E2E2),
    );
  }

  Widget termsAndConditionsAgreement(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: 'By placing an order you agree to our',
          style: TextStyle(
            color: Color(0xFF7C7C7C),
            fontSize: 14,
            fontFamily: Theme.of(context).textTheme.bodyText1!.fontFamily,
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(
                text: " Terms",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            TextSpan(text: " And"),
            TextSpan(
                text: " Conditions",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ]),
    );
  }

  Widget checkoutRow(String label,
      {String? trailingText, Widget? trailingWidget}) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Row(
        children: [
          AppText(
            text: label,
            fontSize: 18,
            color: Color(0xFF7C7C7C),
            fontWeight: FontWeight.w600,
          ),
          Spacer(),
          trailingWidget != null
              ? trailingWidget
              : AppText(
                  text: trailingText.toString(),
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
          SizedBox(
            width: 20,
          ),
          // Icon(
          //   Icons.arrow_forward_ios,
          //   size: 20,
          // )
        ],
      ),
    );
  }

  Future<void> onPlaceOrderClicked() async {
    bool status = await DBService().placeOrder(context, widget.order);
    Navigator.pop(context);
    if (status) {
      showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return OrderAcceptedScreen();
        },
      );
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return OrderFailedDialogue();
        },
      );
    }
  }
}
