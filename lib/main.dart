import 'package:confesseja/res/strings.dart';
import 'package:confesseja/screens/wrapper.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: AppStrings.APP_NAME,
        home: Wrapper()
    );
  }
}
