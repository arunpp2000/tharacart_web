import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tharacart_web/login/login.dart';
import 'package:tharacart_web/login/waiting.dart';
import '../home.dart';
var cWidth;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future loginEvent() async {

    final preferences = await SharedPreferences.getInstance();
    userEmail = preferences.getString('userEmail') ?? '';
    userLogged = preferences.getBool('isLoggedIn') ?? false;

  FirebaseFirestore.instance.collection('admin_users')
                            .where('email',isEqualTo: userEmail).snapshots().listen((event) {
    if( event.docs.isNotEmpty) {
      setState(() {
        verified =event.docs[0]['verified'] ;

        uEmail = event.docs[0].get('email');
        print('=================================');
        print(verified);
        if(verified==true){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Waiting()));
        }
      });
    }
    });


      setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState


      Timer(const Duration(seconds: 3), () {loginEvent();
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //        !userLogged
        //             ? LoginPageWidget()
        //             : !verified
        //            ?Waiting()
        //            :Home(),
        //     ),
        //         (route) => false);
      });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cWidth = MediaQuery.of(context).size.width;
    // var w = MediaQuery.of(context).size.width;
    // var h = MediaQuery.of(context).size.height;
     final sWidth=MediaQuery.of(context).size.width;
    return sWidth>768?Center(
      child: CircularProgressIndicator(),
    ):SizedBox();
  }
}


