import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confesseja/screens/home/home.dart';
import 'package:confesseja/screens/profile_chooser/profile_chooser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileChooserWrapper extends StatefulWidget {
  @override
  _ProfileChooserWrapperState createState() => _ProfileChooserWrapperState();
}

class _ProfileChooserWrapperState extends State<ProfileChooserWrapper> {
  
  Widget widgetToReturn = Scaffold();
  bool getAccountType = true;

  void getUserId(FirebaseUser user) {
    print('getUserId');
    if (user != null) {
      Firestore.instance
          .collection('users')
          .document(user.uid)
          .get()
          .then((value) {
        if (value != null && value.data != null) {
          if(value.data['account_type'] >= 0){
            setState(() {
              getAccountType = false;
              widgetToReturn = Home();
            });
          } else {
            setState(() {
              widgetToReturn = ProfileChooser();
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    if(getAccountType) getUserId(user);
    return widgetToReturn;
  }
}
