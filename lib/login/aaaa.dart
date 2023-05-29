import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class aaaa extends StatefulWidget {
  aaaa({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _aaaaState createState() => _aaaaState();
}

class _aaaaState extends State<aaaa> {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  bool _isLoggedIn = false;

  void _login() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
    } catch (err) {
      print(err);
    }
  }

  void _logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _isLoggedIn
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _googleSignIn.currentUser!.displayName!,
            ),
            Text(
              _googleSignIn.currentUser!.email!,
            ),
            ElevatedButton(
              onPressed: _logout,
              child: Text("Logout"),
            )
          ],
        )
            : ElevatedButton(
          onPressed: _login,
          child: Text("Login with Google"),
        ),
      ),
    );
  }
}
