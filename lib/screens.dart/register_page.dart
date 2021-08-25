import 'package:ecommerce/constant.dart';
import 'package:ecommerce/custwidget.dart/custom_button.dart';
import 'package:ecommerce/custwidget.dart/custon_inp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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

  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: registerMail,
        password: registerPass,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    setState(() {
      _registerFromLoading = true;
    });

    String _create = await _createAccount();
    if (_create != null) {
      _alertDialogeBuilder(_create);

      setState(() {
        _registerFromLoading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  bool _registerFromLoading = false;
  String registerMail = "";
  String registerPass = "";
  FocusNode _passwordfocusnode;

  @override
  void initState() {
    _passwordfocusnode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordfocusnode.dispose();
    super.dispose();
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
              "Create New Account",
              textAlign: TextAlign.center,
              style: Constants.boldHeading,
            ),
          ),
          Column(
            children: [
              CustomInput(
                hint: "Email..",
                onChanged: (value) {
                  registerMail = value;
                },
                onSubmitted: (value) {
                  _passwordfocusnode.requestFocus();
                },
                textInputAction: TextInputAction.next,
              ),
              CustomInput(
                hint: "Password..",
                onChanged: (value) {
                  registerPass = value;
                },
                onSubmitted: (value) {
                  _submitForm();
                },
                isPasswordfield: true,
                focusnode: _passwordfocusnode,
              ),
              CustomButtonAction(
                text: "Create New Account",
                onPressed: () {
                  _submitForm();
                },
                isLoading: _registerFromLoading,

                //  outlinebtn: false,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: CustomButtonAction(
              text: "Back To Login",
              onPressed: () {
                Navigator.pop(context);
              },
              outlinebtn: true,
            ),
          ),
        ],
      ),
    )));
  }
}
