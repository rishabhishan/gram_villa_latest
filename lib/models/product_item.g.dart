// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductItem _$ProductItemFromJson(Map<String, dynamic> json) => ProductItem(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      name: json['name'] as String,
      iconURL: json['iconURL'] as String,
      enabled: json['enabled'] as bool? ?? false,
      default_unit_price: (json['default_unit_price'] as num).toDouble(),
      default_unit_value: (json['default_unit_value'] as num).toDouble(),
      default_unit: json['default_unit'] as String,
      cart_quantity: json['cart_quantity'] as int? ?? 0,
    );

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'name': instance.name,
      'iconURL': instance.iconURL,
      'enabled': instance.enabled,
      'default_unit_price': instance.default_unit_price,
      'default_unit_value': instance.default_unit_value,
      'default_unit': instance.default_unit,
      'cart_quantity': instance.cart_quantity,
    };
