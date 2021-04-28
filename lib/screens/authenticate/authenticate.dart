import 'package:confesseja/screens/authenticate/login.dart';
import 'package:confesseja/screens/authenticate/password_forgot.dart';
import 'package:confesseja/screens/authenticate/register.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  int showLoginView = 0;
  void toggleView(int value) {
    setState(() {
      showLoginView = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (showLoginView) {
      case 0:
        return Login(
          toggleView: toggleView,
        );
      case 1:
        return Register(
          toggleView: toggleView,
        );
      case 2:
        return PasswordForgot(
          toggleView: toggleView,
        );
      default:
        return Login(
          toggleView: toggleView,
        );
    }
  }
}
