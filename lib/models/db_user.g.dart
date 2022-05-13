// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirestoreUser _$FirestoreUserFromJson(Map<String, dynamic> json) =>
    FirestoreUser(
      json['uid'] as String,
      json['displayName'] as String?,
      json['photoUrl'] as String?,
      json['email'] as String?,
      json['phoneNumber'] as String?,
      json['isGoogleSignInSuccessful'] as bool?,
      json['isPhoneVerificationSuccessful'] as bool?,
    );

Map<String, dynamic> _$FirestoreUserToJson(FirestoreUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'isGoogleSignInSuccessful': instance.isGoogleSignInSuccessful,
      'isPhoneVerificationSuccessful': instance.isPhoneVerificationSuccessful,
    };
