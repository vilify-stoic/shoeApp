import 'package:ecommerce/constant.dart';
import 'package:ecommerce/screens.dart/homepage.dart';
import 'package:ecommerce/screens.dart/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LandinPage extends StatefulWidget {
  @override
  _LandinPageState createState() => _LandinPageState();
}

class _LandinPageState extends State<LandinPage> {
  final Future<FirebaseApp> _intialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _intialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error ${snapshot.error}",
                  style: Constants.regularHeading),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.hasError) {
                  return Scaffold(
                      body: Center(
                    child: Text("Error ${streamSnapshot.error}",
                        style: Constants.regularHeading),
                  ));
                }
                if (streamSnapshot.connectionState == ConnectionState.active) {
                  debugPrint("done");
                  User _user = streamSnapshot.data;
                  if (_user == null) {
                    return LoginPage();
                  } else {
                    return HomePage();
                  }
                }
                return Scaffold(
                    body: Center(
                  child: Text(
                    "checking Auth..",
                    style: Constants.regularHeading,
                  ),
                ));
              });
        }
        return Scaffold(
            body: Center(
          child: Text(
            "initialising Aauth..",
            style: Constants.regularHeading,
          ),
        ));
      },
    );
  }
}
