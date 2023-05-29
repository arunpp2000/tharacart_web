import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/util.dart';


/// Tries to sign in or create an account using Firebase Auth.
/// Returns the User object if sign in was successful.
Future<User?> signInOrCreateAccount(
    BuildContext context, Future<UserCredential?> Function() signInFunc) async {
  try {
    final userCredential = await signInFunc();
    await maybeCreateUser(userCredential!.user!);

    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.message}')),
    );
    return null;
  }
}

Future signOut() => FirebaseAuth.instance.signOut();

Future maybeCreateUser(User user) async {
  // GoogleSignInAccount guser = googleSignIn.currentUser;
  // final userRecord = AdminUsersRecord.collection.doc(user.uid);
  // final userExists = await userRecord.get().then((u) => u.exists);
  // if (userExists) {
  //   return;
  // }

  // final userData = createAdminUsersRecordData(
  //   email: user.email,
  //   displayName: user.displayName,
  //   photoUrl: user.photoURL,
  //   uid: user.uid,
  //   createdTime: getCurrentTimestamp,
  //   verified: false,
  // );
  //
  // await userRecord.set(userData);
  FirebaseFirestore.instance.collection('admin_users').doc(user.uid).set({
    'delete':false,
    'email': user.email,
    'displayName': user.displayName,
    'photoUrl': user.photoURL,
    'uid': user.uid,
    'createdTime': getCurrentTimestamp,
    'verified': false,
  });

}

