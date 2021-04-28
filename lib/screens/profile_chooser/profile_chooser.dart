import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confesseja/res/confesseja_icon_icons.dart';
import 'package:confesseja/utils/services/db.dart';
import 'package:confesseja/res/strings.dart';
import 'package:confesseja/utils/services/auth.dart';
//import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileChooser extends StatelessWidget {
  final AuthService _auth = AuthService();

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sair'),
          content: Text('Deseja realmente sair do aplicativo?'),
          actions: <Widget>[
            TextButton(
              child: Text(AppStrings.YES),
              onPressed: () {
                Navigator.pop(context);
                _auth.logout();
              },
            ),
            TextButton(
              child: Text(AppStrings.NO),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    void _setAccountType(int type) {
      Firestore.instance
          .collection(Db.values.userCollection.collectionReference)
          .document(user.uid)
          .setData(
              {'account_type': type, 'admin': false, 'profile_complete': 0},
              merge: true);
    }

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Theme.of(context).accentColor,
            Theme.of(context).primaryColor
          ])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Positioned(
                  top: MediaQuery.of(context).padding.top,
                  child: TextButton(
                    child: Text(
                      'Sair',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    onPressed: () {
                      _showMyDialog(context);
                    },
                  )),
              Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 500),
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Quem sou?",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ElevatedButton(
                                //padding: EdgeInsets.symmetric(
                                //    vertical: 8, horizontal: 16),
                                child: Row(
                                  children: [
                                    Icon(
                                      ConfessejaIcon.penitente,
                                      size: 38,
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppStrings.PROFILE_CHOOSER[
                                                Db.values.accountType.penitente]
                                            .toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  _setAccountType(
                                      Db.values.accountType.penitente);
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              ElevatedButton(
                                //padding: EdgeInsets.symmetric(
                                //    vertical: 8, horizontal: 16),
                                child: Row(
                                  children: [
                                    Icon(
                                      ConfessejaIcon.confessor,
                                      size: 38,
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppStrings.PROFILE_CHOOSER[
                                                Db.values.accountType.confessor]
                                            .toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                                onPressed: () {
                                  _setAccountType(
                                      Db.values.accountType.confessor);
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              ElevatedButton(
                                //padding: EdgeInsets.symmetric(
                                //    vertical: 8, horizontal: 16),
                                child: Row(
                                  children: [
                                    Icon(
                                      ConfessejaIcon.igreja,
                                      size: 38,
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppStrings.PROFILE_CHOOSER[
                                                Db.values.accountType.igreja]
                                            .toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                                onPressed: () {
                                  _setAccountType(Db.values.accountType.igreja);
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
