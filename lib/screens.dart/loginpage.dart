import 'package:ecommerce/constant.dart';
import 'package:ecommerce/custwidget.dart/custom_button.dart';
import 'package:ecommerce/custwidget.dart/custon_inp.dart';
import 'package:ecommerce/screens.dart/register_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String loginMail = "";
  String loginPass = "";
  bool _registerFromLoading = false;
  FocusNode _passwordfocusnode;

  Future<void> _alertDialogeBuilder(String error) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Close Dialog"),
              )
            ],
          );
        });
  }

  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginMail,
        password: loginPass,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    } catch (e) {
      return e.toString();
    }
  }

  void submitlogin() async {
    setState(() {
      _registerFromLoading = true;
    });

    String _login = await _loginAccount();
    if (_login != null) {
      _alertDialogeBuilder(_login);
    }

    setState(() {
      _registerFromLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(top: 24.0),
            child: Text(
              "Welcome User \n Login To Your Account",
              textAlign: TextAlign.center,
              style: Constants.boldHeading,
            ),
          ),
          Column(
            children: [
              CustomInput(
                hint: "Email..",
                onChanged: (value) {
                  loginMail = value;
                },
                onSubmitted: (value) {
                  _passwordfocusnode.requestFocus();
                },
                textInputAction: TextInputAction.next,
              ),
              CustomInput(
                hint: "Password..",
                onChanged: (value) {
                  loginPass = value;
                },
                onSubmitted: (value) {
                  submitlogin();
                },
                isPasswordfield: true,
                focusnode: _passwordfocusnode,
              ),
              CustomButtonAction(
                text: "Login",
                onPressed: () {
                  submitlogin();
                },
                outlinebtn: false,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: CustomButtonAction(
              text: "Create New Account",
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Register()));
              },
              outlinebtn: true,
            ),
          ),
        ],
      ),
    )));
  }
}
