import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gram_villa_latest/models/db_user.dart';

class UserDao {
  final usersRef = FirebaseFirestore.instance
      .collection('users')
      .withConverter<FirestoreUser>(
        fromFirestore: (snapshots, _) =>
            FirestoreUser.fromJson(snapshots.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  Future<bool> userExists(String uid) async {
    DocumentReference ref = usersRef.doc(uid);
    bool exists = (await ref.get()).exists;
    return exists;
  }

  Future<FirestoreUser?> getUser(String uid) async {
    return (await usersRef.doc(uid).get()).data();
  }

  Future<bool> updateUserLastSeen(User user) async {
    DocumentReference ref = usersRef.doc(user.uid);
    if (!(await ref.get()).exists) {
      print("User doesn't exists");
      return false;
    } else {
      ref.update({'lastSeen': DateTime.now()});
    }
    return true;
  }

  void addNewUserData(User user) async {
    DocumentReference ref = usersRef.doc(user.uid);
    FirestoreUser firestoreUser = new FirestoreUser(
      user.uid,
      user.displayName,
      user.photoURL,
      user.email,
      "",
      false,
      false,
    );
    ref.set(firestoreUser);
  }

  void updateLastSeenForUser(User user) async {
    DocumentReference ref = usersRef.doc(user.uid);
    ref.update({'lastSeen': DateTime.now()});
  }

  void addPhoneNumberForUser(User user) async {
    DocumentReference ref = usersRef.doc(user.uid);
    ref.update({'phoneNumber': user.phoneNumber, 'lastSeen': DateTime.now()});
  }

  void markGoogleSignInCompletedForUser(User user) async {
    DocumentReference ref = usersRef.doc(user.uid);
    ref.update({'isGoogleSignInSuccessful': true, 'lastSeen': DateTime.now()});
  }

  void markPhoneVerificationCompletedForUser(User user) async {
    DocumentReference ref = usersRef.doc(user.uid);
    ref.update(
        {'isPhoneVerificationSuccessful': true, 'lastSeen': DateTime.now()});
  }
}
