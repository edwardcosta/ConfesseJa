import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confesseja/res/strings.dart';
import 'package:confesseja/screens/wrapper.dart';
import 'package:confesseja/utils/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
          fontFamily: 'KozukaGothicPro',
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          brightness: Brightness.light,
          primaryColor: Color(0xFF1ECAD6),
          accentColor: Color(0xFF2858BE),
        ),
        darkTheme: ThemeData(
            fontFamily: 'KozukaGothicPro',
            brightness: Brightness.dark,
            primaryColor: Color(0xFF2858BE),
            accentColor: Color(0xFF1ECAD6)),
      ),
    );
  }
}
