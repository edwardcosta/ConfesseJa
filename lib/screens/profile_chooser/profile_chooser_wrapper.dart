import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confesseja/screens/home/home.dart';
import 'package:confesseja/screens/profile_chooser/profile_chooser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileChooserWrapper extends StatefulWidget {
  @override
  _ProfileChooserWrapperState createState() => _ProfileChooserWrapperState();
}

class _ProfileChooserWrapperState extends State<ProfileChooserWrapper> {
  
  Widget widgetToReturn = ProfileChooser();
  bool getAccountType = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void getUserId() async {
    print('getUserId');
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      Firestore.instance
          .collection('users')
          .document(user.uid)
          .get()
          .then((value) {
        if (value.data != null) {
          if(value.data['account_type'] >= 0){
            setState(() {
              getAccountType = false;
              widgetToReturn = Home();
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(getAccountType) getUserId();
    return widgetToReturn;
  }
}
