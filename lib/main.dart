import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'home.dart';
import 'login/login.dart';
import 'login/splashScreen.dart';
String? uId;
var userdata;

setSearchParam(String caseNumber) {
  List<String> caseSearchList = [];
  String temp = "";

  List<String> nameSplits = caseNumber.split(" ");
  for (int i = 0; i < nameSplits.length; i++) {
    String name = "";

    for (int k = i; k < nameSplits.length; k++) {
      name = name + nameSplits[k] + " ";
    }
    temp = "";

    for (int j = 0; j < name.length; j++) {
      temp = temp + name[j];
      caseSearchList.add(temp.toUpperCase());
    }
  }

  return caseSearchList;
}
void main() async {
  if (kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBHvlsNM1d47bynDdwswuDmFwCymELg5fA",
            authDomain: "tharacartonlinestore.firebaseapp.com",
            projectId: "tharacartonlinestore",
            storageBucket: "tharacartonlinestore.appspot.com",
            messagingSenderId: "88595946213",
            appId: "1:88595946213:web:9cebfd8421c3430aefd20c",
            measurementId: "G-R3L6JMJTNN"
        ));
    runApp( MyApp());
  }
  else {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp( MyApp());
  }
}

class MyApp extends StatelessWidget {
   MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tharacart Web',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:SplashScreen(),
    );
  }
}

//firebase target:apply hosting tharacartwebadmin tharacartwebadmin


// StreamBuilder<User?>(
// stream: FirebaseAuth.instance.authStateChanges(),
// builder: (BuildContext context, AsyncSnapshot snapshot) {
// print(snapshot);
// print(snapshot.data);
// if (snapshot.connectionState==ConnectionState.waiting) {
// return CircularProgressIndicator();
// }else if(snapshot.hasData){
// userdata =snapshot.data;
// print(userdata.uid);
// print('home');
// return Home();
// }else if(snapshot.hasError){
// return Text('error');
// }else{
// return LoginPageWidget();
// }
// }),