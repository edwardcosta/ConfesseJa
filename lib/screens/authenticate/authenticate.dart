import 'package:confesseja/screens/authenticate/login.dart';
import 'package:confesseja/screens/authenticate/register.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget{
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate>{

  bool showLoginView = true;
  void toggleView(){
    setState(() {
      showLoginView = !showLoginView;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (showLoginView){
      return Login(toggleView: toggleView,);
    } else {
      return Register(toggleView: toggleView,);
    }
  }
}