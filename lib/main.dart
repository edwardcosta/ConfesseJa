import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confesseja/res/strings.dart';
import 'package:confesseja/screens/wrapper.dart';
import 'package:confesseja/utils/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firestore.instance.settings(persistenceEnabled: true);
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().firebaseUser,
      child: MaterialApp(
        title: AppStrings.APP_NAME,
        home: Wrapper(),
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xFFE8E8E8),
          accentColor: Color(0xFF2E2E2E),
        ),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Color(0xFF2E2E2E),
            accentColor: Color(0xFFE8E8E8)),
      ),
    );
  }
}
