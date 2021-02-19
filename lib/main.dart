import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confesseja/res/colors.dart';
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
            headline1: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
            bodyText1: TextStyle(color: Colors.white),
            bodyText2:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          brightness: Brightness.light,
          primaryColor: AppColors.ACCENT,
          accentColor: AppColors.PRIMARY,
          bottomAppBarColor: AppColors.MENU,
          cardColor: AppColors.ACCENT,
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: AppColors.BUTTON_1,
            textTheme: ButtonTextTheme.primary
          )
        ),
        /*darkTheme: ThemeData(
          fontFamily: 'KozukaGothicPro',
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
            bodyText1: TextStyle(color: Colors.white),
            bodyText2:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          brightness: Brightness.dark,
          primaryColor: AppColors.PRIMARY,
          accentColor: AppColors.ACCENT,
          bottomAppBarColor: AppColors.MENU,
          buttonColor: AppColors.BUTTON_1,
        ),*/
      ),
    );
  }
}
