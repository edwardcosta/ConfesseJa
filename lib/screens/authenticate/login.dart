import 'package:confesseja/res/strings.dart';
import 'package:confesseja/utils/services/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Login extends StatefulWidget {
  final Function toggleView;

  Login({this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Poxa'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Algum erro aconteceu :('),
                Text('Tente novamente'),
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
              right: 0,
              left: 0,
              top: 102,
              child: Center(
                  child: Text(
                AppStrings.REGISTER_LOGIN_TITLE,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1,
              )),
            ),
            Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 500),
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      color: Theme.of(context).primaryColor,
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
                                elevation: 2.0,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextFormField(
                                  validator: (val) {
                                    if (val.isEmpty)
                                      return AppStrings.REGISTER_EMPTY;
                                    if (!EmailValidator.validate(val))
                                      return AppStrings.REGISTER_INVALID_EMAIL;
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
                              Card(
                                elevation: 2.0,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextFormField(
                                  validator: (val) {
                                    if (val.isEmpty)
                                      return AppStrings.REGISTER_EMPTY;
                                    return null;
                                  },
                                  obscureText: true,
                                  decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    labelText: AppStrings.REGISTER_PASSWORD,
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
                                      password = val;
                                    });
                                  },
                                ),
                              ),
                              ElevatedButton(
                                //shape: RoundedRectangleBorder(
                                //    borderRadius: BorderRadius.circular(8)),
                                //color: Theme.of(context).buttonColor,
                                child: Text(
                                  AppStrings.REGISTER_LOGIN,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                //padding: const EdgeInsets.all(4.0),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    dynamic result = await _auth.loginEmail(
                                        email.trim(), password.trim());
                                    if (result == null) {
                                      _showMyDialog();
                                    }
                                  }
                                },
                              ),
                              const Divider(
                                color: Colors.white30,
                                thickness: 5,
                              ),
                              SignInButton(
                                Buttons.Facebook,
                                text: AppStrings.REGISTER_FACEBOOK_BUTTON,
                                onPressed: () async {
                                  dynamic result = await _auth.loginFacebook();
                                  if (result == null) {
                                    _showMyDialog();
                                  }
                                },
                              ),
                              SignInButton(
                                Buttons.Google,
                                text: AppStrings.REGISTER_GOOGLE_BUTTON,
                                onPressed: () async {
                                  dynamic result = await _auth.loginGoogle();
                                  if (result == null) {
                                    _showMyDialog();
                                  }
                                },
                              ),
                              SignInButton(
                                Buttons.Apple,
                                text: AppStrings.REGISTER_APPLE_BUTTON,
                                onPressed: () async {
                                  dynamic result = await _auth.loginGoogle();
                                  if (result == null) {
                                    _showMyDialog();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Center(
                child: Column(
                  children: [
                    TextButton(
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              AppStrings.REGISTER_NOT_REGISTERED,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(' '),
                            Text(
                              AppStrings.REGISTER_GOTO_SIGNUP,
                              style: Theme.of(context).textTheme.bodyText2,
                            )
                          ]),
                      onPressed: () {
                        widget.toggleView(1);
                      },
                    ),
                    TextButton(
                      child: Text(
                        AppStrings.REGISTER_PASSWORD_FORGOT,
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        widget.toggleView(2);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
