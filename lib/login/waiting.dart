
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tharacart_web/login/login.dart';
import '../home.dart';
import 'package:flutter/material.dart';




class Waiting extends StatefulWidget {
  const Waiting({Key? key}) : super(key: key);

  @override
  _WaitingState createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {

  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey.shade100,
      body: verified==true?Home():SafeArea(
        child: Center(
          child: Text("Please Wait for Admin's Approval"),
        ),
      ),
    );
  }

}
