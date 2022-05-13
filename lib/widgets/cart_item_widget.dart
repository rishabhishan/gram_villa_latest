import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gram_villa_latest/dao/cart_dao.dart';
import 'package:gram_villa_latest/models/product_item.dart';
import 'package:gram_villa_latest/styles/colors.dart';
import 'package:provider/provider.dart';

import 'app_text.dart';

class CartItemWidget extends StatefulWidget {
  CartItemWidget({Key? key, required this.item}) : super(key: key);
  final ProductItem item;

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  final double height = 400;

  final Color borderColor = Color(0xffE2E2E2);

  final double borderRadius = 18;

  int amount = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: height,
      margin: EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            imageWidget(),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: widget.item.displayName,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  AppText(
                    text:
                        "${widget.item.default_unit_value.toStringAsFixed(0)} ${widget.item.default_unit}",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF7C7C7C),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text:
                            "Rs ${widget.item.default_unit_price.toStringAsFixed(0)}",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      addWidget(context)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      width: 80,
      child: CachedNetworkImage(imageUrl: widget.item.iconURL),
    );
  }

  double getPrice() {
    return widget.item.default_unit_price * amount;
  }

  Widget addWidget(context) {
    CartDao cartDao = Provider.of<CartDao>(context, listen: false);

    return Consumer<CartDao>(builder: (context, cart, child) {
      return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                print("removing from cart");
                cartDao.removeItem(context, widget.item);
              },
              child: Container(
                height: 22,
                width: 22,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.black12.withOpacity(0.1)),
                child: const Center(
                  child: Icon(
                    Icons.remove,
                    color: AppColors.secondaryColor,
                    size: 16,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AppText(
                text: widget.item.cart_quantity.toString(),
                fontSize: 14,
              ),
            ),
            GestureDetector(
              onTap: () {
                print("adding to cart");
                cartDao.addItem(context, widget.item);
              },
              child: Container(
                height: 22,
                width: 22,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.black12.withOpacity(0.1)),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: AppColors.secondaryColor,
                    size: 16,
                  ),
                ),
              ),
            )
          ]);
    });
  }
}
