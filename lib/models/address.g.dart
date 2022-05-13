// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      json['building'] as String,
      json['street'] as String,
      json['pincode'] as String,
      json['city'] as String,
      json['state'] as String,
      DateTime.parse(json['createdAt'] as String),
      (json['lat'] as num).toDouble(),
      (json['lng'] as num).toDouble(),
      DateTime.parse(json['promisedDeliveryDate'] as String),
      json['actualDeliveryDate'] == null
          ? null
          : DateTime.parse(json['actualDeliveryDate'] as String),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'building': instance.building,
      'street': instance.street,
      'pincode': instance.pincode,
      'city': instance.city,
      'state': instance.state,
      'createdAt': instance.createdAt.toIso8601String(),
      'lat': instance.lat,
      'lng': instance.lng,
      'promisedDeliveryDate': instance.promisedDeliveryDate.toIso8601String(),
      'actualDeliveryDate': instance.actualDeliveryDate?.toIso8601String(),
    };
