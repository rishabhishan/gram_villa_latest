import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gram_villa_latest/dao/user_dao.dart';
import 'package:gram_villa_latest/models/db_user.dart';

class AuthService extends ChangeNotifier {
  static final AuthService _authservice = AuthService._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final UserDao userDao = new UserDao();

  factory AuthService() {
    return _authservice;
  }

  AuthService._internal();

  Future<bool> isLoggedIn() async {
    if (_auth.currentUser == null) {
      return false;
    } else {
      FirestoreUser? user = await userDao.getUser(_auth.currentUser!.uid);
      if (user != null) {
        return user.isGoogleSignInSuccessful! &&
            user.isPhoneVerificationSuccessful!;
      }
    }
    return false;
  }

  String? get uid {
    return _auth.currentUser?.uid;
  }

  String? email() {
    return _auth.currentUser?.email;
  }

  String? phone() {
    return _auth.currentUser?.phoneNumber;
  }

  // Firebase user one-time fetch
  User? get getUser => _auth.currentUser;

  // Firebase user a realtime stream
  Stream<User?> get user => _auth.authStateChanges();

  Future<User?> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      assert(!user!.isAnonymous);

      final User currentUser = _auth.currentUser!;
      assert(user!.uid == currentUser.uid);

      print("user name: ${user!.displayName}");
      if (!await userDao.userExists(currentUser.uid)) {
        userDao.addNewUserData(currentUser);
        userDao.markGoogleSignInCompletedForUser(currentUser);
      } else {
        userDao.updateLastSeenForUser(currentUser);
      }

      return user;
    } catch (error) {
      return null;
    }
  }

  Future<void> refreshLastSeen() async {
    userDao.updateLastSeenForUser(getUser!);
  }

  Future<void> phoneSignIn() async {
    try {
      final User currentUser = await _auth.currentUser!;
      userDao.addPhoneNumberForUser(currentUser);
      userDao.markPhoneVerificationCompletedForUser(currentUser);
    } catch (error) {
      return null;
    }
  }

  // sign out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
