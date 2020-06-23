import 'package:confesseja/res/colors.dart';
import 'package:confesseja/utils/services/auth.dart';
import 'package:flutter/material.dart';

class HomePriest extends StatefulWidget {
  @override
  _HomePriestState createState() => _HomePriestState();
}

class _HomePriestState extends State<HomePriest> {
  final _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: <Widget>[
          Center(
            child: RaisedButton(child: Text('Sair'), onPressed: () {
              _auth.logout();
            }),
          ),
        ],
      ),
    );
  }
}