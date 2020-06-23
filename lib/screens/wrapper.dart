import 'package:confesseja/screens/authenticate/authenticate.dart';
import 'package:confesseja/screens/profile_chooser/profile_chooser_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    if(user == null){
      return Authenticate();
    } else {
      return ProfileChooserMain();
    }
  }
}