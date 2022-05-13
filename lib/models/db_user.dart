import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'db_user.g.dart';

@JsonSerializable(explicitToJson: true)
class FirestoreUser {
  String uid;
  String? displayName;
  String? photoUrl;
  String? email;
  String? phoneNumber;
  bool? isGoogleSignInSuccessful = false;
  bool? isPhoneVerificationSuccessful = false;

  FirestoreUser(
      this.uid,
      this.displayName,
      this.photoUrl,
      this.email,
      this.phoneNumber,
      this.isGoogleSignInSuccessful,
      this.isPhoneVerificationSuccessful);

  factory FirestoreUser.fromJson(Map<String, dynamic> json) =>
      _$FirestoreUserFromJson(json);

  Map<String, dynamic> toJson() => _$FirestoreUserToJson(this);
}
