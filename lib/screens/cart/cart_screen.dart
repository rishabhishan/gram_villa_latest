import 'package:flutter/material.dart';
import 'package:gram_villa_latest/dao/cart_dao.dart';
import 'package:gram_villa_latest/models/order.dart';
import 'package:gram_villa_latest/screens/address/add_address_screen.dart';
import 'package:gram_villa_latest/screens/helpers/column_with_seprator.dart';
import 'package:gram_villa_latest/service/auth_service.dart';
import 'package:gram_villa_latest/widgets/app_button.dart';
import 'package:gram_villa_latest/widgets/app_text.dart';
import 'package:gram_villa_latest/widgets/cart_item_widget.dart';
import 'package:nanoid/nanoid.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../Constants.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: paddingScreen,
            child: Column(
              children: [
                getHeader(),
                Consumer<CartDao>(
                  builder: (context, cart, child) {
                    return Column(
                      children: getChildrenWithSeperator(
                        addToLastChild: false,
                        widgets: cart.productItems.values
                            .map((v) => Container(
                                  width: double.maxFinite,
                                  child: CartItemWidget(
                                    item: v,
                                  ),
                                ))
                            .toList(),
                        seperator: Divider(
                          thickness: 1,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                Consumer<CartDao>(builder: (context, cart, child) {
                  return getCheckoutButton(cart);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCheckoutButton(CartDao cart) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: AppButton(
        label: "Checkout",
        fontWeight: FontWeight.w600,
        trailingWidget: getButtonPriceWidget(cart.getCartTotal()),
        onPressed: () {
          showBottomSheet(cart);
        },
      ),
    );
  }

  Widget getButtonPriceWidget(double cartTotal) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Color(0xff489E67),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "Rs " + cartTotal.toStringAsFixed(0),
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Order getOrder(CartDao cart) {
    AuthService authService = Provider.of<AuthService>(context, listen: false);
    String uid = authService.uid.toString();
    DateTime currentTime = DateTime.now();
    String paymentMode = DEFAULT_PAYMENT_MODE;
    var id = customAlphabet('1234567890', 10);
    Order order = Order(
        id,
        uid,
        STATUS.created,
        currentTime,
        currentTime,
        null,
        paymentMode,
        cart.getCartTotal(),
        cart.productItems.values.toList());

    return order;
  }

  void showBottomSheet(CartDao cart) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return AddAddressScreen(getOrder(cart));
        });
  }

  Widget getHeader() {
    return Column(
      children: [
        Center(
          child: AppText(
            text: "My Cart",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
