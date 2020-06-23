import 'package:confesseja/models/user.dart';
import 'package:confesseja/res/colors.dart';
import 'package:confesseja/utils/services/auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String welcomeText;
  final User user;
  Profile({this.welcomeText, this.user});

  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
    final topPadding = MediaQuery.of(context).padding.top;
    Color bckgColor;

    switch (user.accountType.toInt()) {
      case 0:
        bckgColor = AppColors.lightPrimaryColor;
        break;
      case 1:
        bckgColor = AppColors.perishColor;
        break;
      case 2:
        bckgColor = AppColors.primaryColor;
        break;
      case 42:
        bckgColor = AppColors.secondaryColor;
        break;
      default:
        bckgColor = AppColors.lightPrimaryColor;
    }

    return Scaffold(
      backgroundColor: bckgColor,
      body: Stack(children: <Widget>[
        Positioned(
          top: topPadding,
          child: IconButton(
              icon: Icon(Icons.arrow_back,color: AppColors.iconTextColor,),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        Padding(
          padding: EdgeInsets.only(top: topPadding + 20.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: 'welcomeText',
              child: Material(
                color: Colors.transparent,
                child: Text(welcomeText,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.titleTextColor,
                    )),
              ),
            ),
          ),
        ),
        Center(
          child: RaisedButton(
              child: Text('Sair'),
              onPressed: () async {
                await _auth.logout();
                Navigator.of(context).pop();
              }),
        )
      ]),
    );
  }
}
