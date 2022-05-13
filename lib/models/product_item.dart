import 'package:json_annotation/json_annotation.dart';

part 'product_item.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductItem {
  final String id;
  final String displayName;
  final String name;
  final String iconURL;
  final bool enabled;
  final double default_unit_price;
  final double default_unit_value;
  final String default_unit;
  int cart_quantity;

  ProductItem(
      {required this.id,
      required this.displayName,
      required this.name,
      required this.iconURL,
      this.enabled = false,
      required this.default_unit_price,
      required this.default_unit_value,
      required this.default_unit,
      this.cart_quantity = 0});

  factory ProductItem.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);

  Map<String, dynamic> toJson() => _$ProductItemToJson(this);
}
