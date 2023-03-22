import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import 'home.dart';

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
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Home(),
    );
  }
}

//firebase target:apply hosting tharacartwebadmin tharacartwebadmin