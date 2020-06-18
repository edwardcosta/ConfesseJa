import 'package:confesseja/res/strings.dart';
import 'package:confesseja/screens/wrapper.dart';
import 'package:confesseja/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
        child: MaterialApp(
          title: AppStrings.APP_NAME,
          home: Wrapper()
      ),
    );
  }
}
