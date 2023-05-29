import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../home.dart';
import '../login/login.dart';

class GoogleButton extends StatefulWidget {
  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.blueGrey, width: 3),
        ),
        color: Colors.white,
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.blueGrey.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.blueGrey, width: 3),
          ),
          elevation: 0,
        ),
        onPressed: () async {
          setState(() {
            _isProcessing = true;
          });

          final user = await signInWithGoogle(context);
          if (user == null) {
            return;
          }
          await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) =>
              // NavBarPage(initialPage: 'HomePage'),
              Home(),
            ),
                (r) => false,
          );
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
          // await signInWithGoogle(context);
          setState(() {
            _isProcessing = false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: _isProcessing
              ? CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
              Colors.blueGrey,
            ),
          )
              : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("assets/images/google_logo.png"),
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Google Sign In',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width*0.02,
                    color: Colors.blueGrey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }  signInWithGoogle(BuildContext context) async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);

    currentUserName = userCredential.user!.displayName!;
    currentUserImage = userCredential.user!.photoURL!;
    currentUserEmail = userCredential.user!.email!;
    currentUserId = userCredential.user!.uid!;
    log(usersId.toString());
    if(usersId!.contains(currentUserId!)) {
      log('TRUE TRUE');
      print('TRUE TRUE');
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context)=> Home()), (route) => false);
    }
    else{
      log('                         FALSE FALSE');
      print('false');
      FirebaseFirestore.instance
          .collection('admin_users')
          .doc(currentUserId)
          .set({
        "uid": currentUserId,
        "display_name": currentUserName,
        "email": currentUserEmail,
        "photo_url": currentUserImage,
        "created_time": DateTime.now(),
        'delete':false,
        'verified':false,
      })
          .then((value) => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
              (route) => false))
          .catchError((e) {
        print("Error Code is ${e}");
      });
    }
  }

}
