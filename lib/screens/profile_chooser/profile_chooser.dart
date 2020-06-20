import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confesseja/res/colors.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileChooser extends StatefulWidget {
  @override
  _ProfileChooserState createState() => _ProfileChooserState();
}

class _ProfileChooserState extends State<ProfileChooser> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  double currentPage = 0;
  FirebaseUser _user;

  void getUser() async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      setState(() {
        _user = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return Stack(children: <Widget>[
      PageView(
        controller: PageController(),
        children: [
          Scaffold(
            backgroundColor: AppColors.lightPrimaryColor,
            body: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                child: GestureDetector(
                  onTap: () {
                    Firestore.instance
                        .collection('users')
                        .document(_user.uid)
                        .setData({'account_type': currentPage},merge: true);
                  },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage('images/bootwise-icon-02-1.png'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: AppColors.lightPrimaryColor,
            body: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                child: GestureDetector(
                  onTap: () {
                    Firestore.instance
                        .collection('users')
                        .document(_user.uid)
                        .setData({'account_type': currentPage},merge: true);
                  },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage('images/church.png'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: AppColors.lightPrimaryColor,
            body: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                child: GestureDetector(
                  onTap: () {
                    Firestore.instance
                        .collection('users')
                        .document(_user.uid)
                        .setData({'account_type': currentPage},merge: true);
                  },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage('images/priest.png'),
                          )
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
                  color: AppColors.iconTextColor,
                  activeColor: AppColors.secondaryColor),
            ),
          )),
    ]);
  }
}
