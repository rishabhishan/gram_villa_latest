import 'package:gram_villa_latest/models/product_item.dart';

class CartItem {
  String productId;
  int units;

  CartItem({
    required this.productId,
    this.units = 0
  });
}
