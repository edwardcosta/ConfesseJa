import 'package:confesseja/models/user.dart';
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

    return Scaffold(
      body: Stack(children: <Widget>[
        Positioned(
          top: topPadding,
          child: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
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
                    )),
              ),
            ),
          ),
        ),
        Center(
          child: ElevatedButton(
              child: Text(
                'Sair',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              //color: Theme.of(context).accentColor,
              onPressed: () async {
                await _auth.logout();
                Navigator.of(context).pop();
              }),
        )
      ]),
    );
  }
}
