// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategory _$ProductCategoryFromJson(Map<String, dynamic> json) =>
    ProductCategory(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      name: json['name'] as String,
      iconURL: json['iconURL'] as String,
      enabled: json['enabled'] as bool? ?? false,
    );

Map<String, dynamic> _$ProductCategoryToJson(ProductCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'name': instance.name,
      'iconURL': instance.iconURL,
      'enabled': instance.enabled,
    };
