// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      json['orderId'] as String,
      json['uid'] as String,
      $enumDecode(_$STATUSEnumMap, json['status']),
      DateTime.parse(json['createdAt'] as String),
      DateTime.parse(json['updatedAt'] as String),
      json['deliveryAddress'] == null
          ? null
          : Address.fromJson(json['deliveryAddress'] as Map<String, dynamic>),
      json['paymentMode'] as String,
      (json['billAmount'] as num).toDouble(),
      (json['productItems'] as List<dynamic>)
          .map((e) => ProductItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'uid': instance.uid,
      'status': _$STATUSEnumMap[instance.status],
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deliveryAddress': instance.deliveryAddress?.toJson(),
      'paymentMode': instance.paymentMode,
      'billAmount': instance.billAmount,
      'orderId': instance.orderId,
      'productItems': instance.productItems.map((e) => e.toJson()).toList(),
    };

const _$STATUSEnumMap = {
  STATUS.created: 'created',
  STATUS.delivered: 'delivered',
  STATUS.in_progress: 'in_progress',
  STATUS.cancelled: 'cancelled',
  STATUS.closed: 'closed',
  STATUS.non_deliverable: 'non_deliverable',
};
