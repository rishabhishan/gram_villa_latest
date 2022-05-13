import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gram_villa_latest/models/product_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  String building;
  String street;
  String pincode;
  String city;
  String state;
  DateTime createdAt;
  double lat;
  double lng;
  DateTime promisedDeliveryDate;
  DateTime? actualDeliveryDate;

  Address(
      this.building,
      this.street,
      this.pincode,
      this.city,
      this.state,
      this.createdAt,
      this.lat,
      this.lng,
      this.promisedDeliveryDate,
      this.actualDeliveryDate);

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  String getDisplayAddressShort() {
    return this.street.substring(0, min(this.street.length, 20));
  }
  String getFullAddress() {
    return this.building + ", " + this.street+ ", " +this.city;
  }
}
