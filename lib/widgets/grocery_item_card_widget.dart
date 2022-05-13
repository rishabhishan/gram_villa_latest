import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gram_villa_latest/dao/cart_dao.dart';
import 'package:gram_villa_latest/models/product_item.dart';
import 'package:gram_villa_latest/styles/colors.dart';
import 'package:provider/provider.dart';

import 'app_text.dart';

class GroceryItemCardWidget extends StatefulWidget {
  GroceryItemCardWidget({Key? key, required this.item}) : super(key: key);
  final ProductItem item;

  @override
  State<GroceryItemCardWidget> createState() => _GroceryItemCardWidgetState();
}

class _GroceryItemCardWidgetState extends State<GroceryItemCardWidget> {
  final double width = 160;
  late ProductItem item;

  final double height = 150;

  final Color borderColor = const Color(0xffE2E2E2);

  final double borderRadius = 18;

  @override
  Widget build(BuildContext context) {
    item = widget.item;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: imageWidget(),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            child: AppText(
              text: item.displayName,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          AppText(
            text:
                "${item.default_unit_value.toStringAsFixed(0)} ${item.default_unit}",
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
                text: "Rs ${item.default_unit_price.toStringAsFixed(0)}",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              addWidget(context)
            ],
          ),
          //addWidget(context)
        ],
      ),
    );
  }

  Widget imageWidget() {
    // return Container(
    //   decoration: BoxDecoration(
    //       color: Colors.transparent
    //       ),
    //   // child: Image.network(
    //   // "https://www.pikpng.com/pngl/m/55-555489_potato-vector-clipart-potatoes-vegetables-png-download.png"
    //   // ),
    //   child: Image.asset(
    //   "assets/images/potato.png"
    //   ),
    // );
    return CachedNetworkImage(
      imageUrl: item.iconURL,
      fit: BoxFit.fill,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Widget addWidget(context) {
    CartDao cartDao = Provider.of<CartDao>(context, listen: false);

    return Consumer<CartDao>(builder: (context, cart, child) {
      if (item.cart_quantity == 0) {
        return GestureDetector(
          onTap: () {
            print("Adding to cart");
            cartDao.addItem(context, item);
          },
          child: Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.secondaryColor),
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        );
      } else {
        return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  print("removing from cart");
                  cartDao.removeItem(context, item);
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
                  text: item.cart_quantity.toString(),
                  fontSize: 14,
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("adding to cart");
                  cartDao.addItem(context, item);
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
      }
    });
  }
}
