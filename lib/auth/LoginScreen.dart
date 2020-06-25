
import 'package:WorkzApp_flutter/main.dart';
import 'package:WorkzApp_flutter/mainpages/homescreen.dart';
import 'package:WorkzApp_flutter/model/user.dart';
import 'package:WorkzApp_flutter/utils/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'Authenticate.dart';


final _fireStoreUtils = FireStoreUtils();

class LoginScreen extends StatefulWidget {
  @override
  State createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
      ),
      body: Form(
        key: _key,
        autovalidate: _validate,
        child: ListView(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 32.0, right: 16.0, left: 16.0),
              child: Text(
                'Sign In',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: double.infinity),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, right: 12.0, left: 12.0),
                child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    textInputAction: TextInputAction.next,
                    validator: validateEmail,
                    onSaved: (String val) {
                      email = val;
                    },
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).nextFocus(),
                    controller: _emailController,
                    style: TextStyle(fontSize: 18.0),
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        contentPadding:
                            new EdgeInsets.only(left: 16, right: 16),
                        fillColor: Colors.white,
                        hintText: 'E-mail Address',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2.0)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ))),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: double.infinity),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, right: 12.0, left: 12.0),
                child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    validator: validatePassword,
                    obscureText: true,
                    onSaved: (String val) {
                      email = val;
                    },
                    controller: _passwordController,
                    onFieldSubmitted: (_) async {
                      await onClick(_emailController.text, _passwordController.text);
                    },
                    textInputAction: TextInputAction.done,
                    style: TextStyle(fontSize: 18.0),
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        contentPadding:
                            new EdgeInsets.only(left: 16, right: 16),
                        fillColor: Colors.white,
                        hintText: 'Password',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2.0)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ))),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 20.0, left: 20.0, top: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'Log In',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  textColor: Colors.white,
                  splashColor: Colors.blue,
                  onPressed: () async {
                    await onClick(
                        _emailController.text, _passwordController.text);
                  },
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side:
                          BorderSide(color: Colors.blue)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onClick(String email, String password) async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      showProgress(context, 'Logging in, please wait...', false);
      User user =
          await loginWithUserNameAndPassword(email.trim(), password.trim());
      if (user != null)
        pushAndRemoveUntil(context, ExampleCustomMenu(user: user,), false);
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  Future<User> loginWithUserNameAndPassword(
      String email, String password) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      
      DocumentSnapshot documentSnapshot = await FireStoreUtils.firestore
          .collection("USERS")
          .document(result.user.uid)
          .get();
      User user;
      if (documentSnapshot != null && documentSnapshot.exists) {
        user = User.fromJson(documentSnapshot.data);
        user.active = true;
        await _fireStoreUtils.updateCurrentUser(user, context);
        hideProgress();
        MyHomePage.currentUser = user;
      }
      return user;
    } 
    catch (exception) {
      hideProgress();
      switch ((exception as PlatformException).code) {
        case 'ERROR_INVALID_EMAIL':
          showAlertDialog(
              context, 'Couldn\'t Authinticate', 'email address is malformed');
          break;
        case 'ERROR_WRONG_PASSWORD':
          showAlertDialog(context, 'Couldn\'t Authinticate', 'wrong password');
          break;
        case 'ERROR_USER_NOT_FOUND':
          showAlertDialog(context, 'Couldn\'t Authinticate',
              'no user corresponding to the given email address');
          break;
        case 'ERROR_USER_DISABLED':
          showAlertDialog(
              context, 'Couldn\'t Authinticate', 'user has been disabled');
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          showAlertDialog(context, 'Couldn\'t Authinticate',
              'too many attempts to sign in as this user');
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          showAlertDialog(context, 'Couldn\'t Authinticate',
              'Email & Password accounts are not enabled');
          break;
      }
      print(exception.toString());
      return null;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
