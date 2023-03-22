import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';



import '../home.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
String? currentUserName;
String ?  currentUserImage;
String  ? currentUserEmail;
String   ?currentUserId;
String ?usersId;
class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    
    // FirebaseAuth.instance.signInWithEmailAndPassword(email: 'admin@gmail.com', password: '123456');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
          child: Material(
            elevation: 5,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        )
                      ),
                      child: Center(child: LottieBuilder.network('https://assets5.lottiefiles.com/packages/lf20_4vlxeulb.json',fit: BoxFit.cover,)),

                    )),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                    child: Container(



                      decoration: BoxDecoration(
                        color: Colors.white,

                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(child: SizedBox()),
                          Center(
                            child: Text('Sign in',style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height*0.04,color: Colors.black,fontWeight: FontWeight.w500
                            ),),
                          ),

                          ElevatedButton(onPressed: () async {
                           // await signInWithGoogle(context);


Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                          }, child: Text(' Sign in')),

                          Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  signInWithGoogle(BuildContext context) async {
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
