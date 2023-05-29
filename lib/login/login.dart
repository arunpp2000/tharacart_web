
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tharacart_web/login/splashScreen.dart';
import 'package:tharacart_web/login/waiting.dart';
import '../home.dart';
import 'package:flutter/material.dart';
String? currentUserName;
String ?  currentUserImage;
String  ? currentUserEmail;
String   ?currentUserId;
String ?usersId;

bool userLogged = false;
String userEmail = '';
String? uEmail;

late bool  verified=false;


class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoggedIn = false;
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  bool loadOrder=false;
  // late bool  verified=false;
  bool loaded =false;
  void _login() async {
    try {
      await googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
      if(_isLoggedIn==true){
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('userEmail', googleSignIn.currentUser!.email);
        print(googleSignIn.currentUser!.email);
        QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('admin_users')
        .where('email',isEqualTo: googleSignIn.currentUser!.email)
        .get();
        if(snap.docs.isEmpty){
          print('if part');
          FirebaseFirestore.instance.collection('admin_users').doc(googleSignIn.currentUser!.id).set({
            'delete':false,
            'email': googleSignIn.currentUser!.email,
            'display_name': googleSignIn.currentUser!.displayName,
            'photo_url': googleSignIn.currentUser!.photoUrl,
            'uid': googleSignIn.currentUser!.id,
            'created_time': DateTime.now(),
            'verified': false,
          });

          if(verified==true){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home(),), (route) => false);
          }else{
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SplashScreen(),), (route) => false);

          }

        }else{
          print('else part');
          print(snap.docs.first.id);
          FirebaseFirestore.instance.collection('admin_users').doc(snap.docs.first.id).update({
            'created_time': DateTime.now(),
          });
           Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) =>
              // NavBarPage(initialPage: 'HomePage'),
              Home(),
            ),
                (r) => false,
          );

        }
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();

    // FirebaseAuth.instance.signInWithEmailAndPassword(email: 'admin@gmail.com', password: '123456');
  }

  @override
  Widget build(BuildContext context) {
    final sWidth=MediaQuery.of(context).size.width;
    return sWidth>768? Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: _login,
            child: Text("Login with Google"),
          ),
        ),
      ),
    ):SizedBox();
  }

}
