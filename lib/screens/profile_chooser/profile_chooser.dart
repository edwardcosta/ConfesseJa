import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confesseja/res/server_values.dart';
import 'package:confesseja/res/strings.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileChooser extends StatefulWidget {
  @override
  _ProfileChooserState createState() => _ProfileChooserState();
}

class _ProfileChooserState extends State<ProfileChooser> {
  double currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    void _setAccountType() {
      Firestore.instance
          .collection(ServerValues.USERS_COLLECTION)
          .document(user.uid)
          .setData({'account_type': currentPage,'admin': false, 'profile_complete': 0}, merge: true);
    }

    return Stack(children: <Widget>[
      PageView(
        controller: PageController(),
        children: [
          Scaffold(
            body: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                child: GestureDetector(
                  onTap: () {
                    _setAccountType();
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage('assets/images/laity.png'),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            AppStrings.PROFILE_CHOOSER[0],
                            style: AppStrings.TITLE_STYLE,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Scaffold(
            body: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                child: GestureDetector(
                  onTap: () {
                    _setAccountType();
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage('assets/images/church.png'),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            AppStrings.PROFILE_CHOOSER[1],
                            style: AppStrings.TITLE_STYLE,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Scaffold(
            body: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                child: GestureDetector(
                  onTap: () {
                    _setAccountType();
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage('assets/images/priest.png'),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            AppStrings.PROFILE_CHOOSER[2],
                            style: AppStrings.TITLE_STYLE,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        onPageChanged: (val) {
          setState(() {
            currentPage = val.toDouble();
          });
        },
      ),
      Padding(
          padding: EdgeInsets.only(bottom: 60.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: DotsIndicator(
              dotsCount: 3,
              position: currentPage,
              decorator: DotsDecorator(
                  color: Theme.of(context).primaryColor,
                  activeColor: Theme.of(context).accentColor),
            ),
          )),
    ]);
  }
}
