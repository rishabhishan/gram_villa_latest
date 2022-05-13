import 'package:json_annotation/json_annotation.dart';

part 'product_category.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductCategory {
  final String id;
  final String displayName;
  final String name;
  final String iconURL;
  final bool enabled;

  ProductCategory({required this.id, required this.displayName, required this.name, required this.iconURL, this.enabled = false});

  factory ProductCategory.fromJson(Map<String, dynamic> json) => _$ProductCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryToJson(this);

}