import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gram_villa_latest/models/product_item.dart';
import 'package:json_annotation/json_annotation.dart';

import 'address.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  String uid;
  STATUS status;
  DateTime createdAt;
  DateTime updatedAt;
  Address? deliveryAddress;
  String paymentMode;
  double billAmount;
  String orderId;
  List<ProductItem> productItems;

  Order(
      this.orderId,
      this.uid,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deliveryAddress,
      this.paymentMode,
      this.billAmount,
      this.productItems
      );

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

}

enum STATUS {
  created,
  delivered,
  in_progress,
  cancelled,
  closed,
  non_deliverable
}

String describeEnum(Object enumEntry) {
  final String description = enumEntry.toString();
  final int indexOfDot = description.indexOf('.');
  assert(
  indexOfDot != -1 && indexOfDot < description.length - 1,
  'The provided object "$enumEntry" is not an enum.',
  );
  return description.substring(indexOfDot + 1);
}
