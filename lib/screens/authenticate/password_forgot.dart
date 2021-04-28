import 'package:confesseja/res/strings.dart';
import 'package:confesseja/utils/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class PasswordForgot extends StatefulWidget {
  final Function toggleView;

  PasswordForgot({this.toggleView});

  @override
  _PasswordForgotSate createState() => _PasswordForgotSate();
}

class _PasswordForgotSate extends State<PasswordForgot> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Email enviado'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Se o email inserido estiver correto,'),
                Text('você receberá um email em alguns instantes.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.toggleView(0);
        return false;
      },
      child: Container(
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
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                    onPressed: () {
                      widget.toggleView(0);
                    }),
              ),
              Positioned(
                right: 0,
                left: 0,
                top: 102,
                child: Center(
                    child: Text(
                  AppStrings.REGISTER_PW_FORGOT_TITLE,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1,
                )),
              ),
              Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 500),
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Card(
                                  color: Colors.white,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: TextFormField(
                                    validator: (val) {
                                      if (val.isEmpty)
                                        return AppStrings.REGISTER_EMPTY;
                                      if (!EmailValidator.validate(val))
                                        return AppStrings
                                            .REGISTER_INVALID_EMAIL;
                                      return null;
                                    },
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      labelText: AppStrings.REGISTER_EMAIL,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        email = val;
                                      });
                                    },
                                  ),
                                ),
                                ElevatedButton(
                                  child: Text(
                                    AppStrings.REGISTER_PW_FORGOT_SEND,
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      await _auth.sendPasswordResetEmail(email);
                                      _showMyDialog();
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
