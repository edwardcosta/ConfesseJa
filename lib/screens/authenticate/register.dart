import 'package:confesseja/res/strings.dart';
import 'package:confesseja/utils/services/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String retypedPassword = '';
  bool _obscurePassword = true;
  bool _obscureRPassword = true;

  final RegExp hasUppercase = new RegExp('[A-Z]');
  final RegExp hasLowercase = new RegExp('[a-z]');
  final RegExp hasNumber = new RegExp('[0-9]');
  final RegExp hasSymbol = new RegExp('[!@#\$&*~]');

  void _togglePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleRPassword() {
    setState(() {
      _obscureRPassword = !_obscureRPassword;
    });
  }

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
          body: Stack(children: <Widget>[
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
                AppStrings.REGISTER_SIGNUP_TITLE,
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
                                color: Colors.white,
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextFormField(
                                  obscureText: _obscurePassword,
                                  validator: (val) {
                                    if (val.isEmpty)
                                      return AppStrings.REGISTER_EMPTY;
                                    if (val.length < 6)
                                      return AppStrings
                                          .REGISTER_PASSWORD_LENGTH;
                                    if (!hasUppercase.hasMatch(val))
                                      return AppStrings
                                          .REGISTER_PASSWORD_UPPERCASE;
                                    if (!hasLowercase.hasMatch(val))
                                      return AppStrings
                                          .REGISTER_PASSWORD_LOWERCASE;
                                    if (!hasNumber.hasMatch(val))
                                      return AppStrings
                                          .REGISTER_PASSWORD_NUMBER;
                                    if (!hasSymbol.hasMatch(val))
                                      return AppStrings
                                          .REGISTER_PASSWORD_SYMBOL;
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: AppStrings.REGISTER_PASSWORD,
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.remove_red_eye),
                                      onPressed: _togglePassword,
                                    ),
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
                              Card(
                                color: Colors.white,
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextFormField(
                                  obscureText: _obscureRPassword,
                                  validator: (val) {
                                    if (val.isEmpty)
                                      return AppStrings.REGISTER_EMPTY;
                                    if (val != password)
                                      return AppStrings.REGISTER_PASSWORD_MATCH;
                                    if (val.length < 6)
                                      return AppStrings
                                          .REGISTER_PASSWORD_LENGTH;
                                    if (!hasUppercase.hasMatch(val))
                                      return AppStrings
                                          .REGISTER_PASSWORD_UPPERCASE;
                                    if (!hasLowercase.hasMatch(val))
                                      return AppStrings
                                          .REGISTER_PASSWORD_LOWERCASE;
                                    if (!hasNumber.hasMatch(val))
                                      return AppStrings
                                          .REGISTER_PASSWORD_NUMBER;
                                    if (!hasSymbol.hasMatch(val))
                                      return AppStrings
                                          .REGISTER_PASSWORD_SYMBOL;
                                    return null;
                                  },
                                  decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    labelText:
                                        AppStrings.REGISTER_RETYPE_PASSWORD,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.remove_red_eye),
                                      onPressed: _toggleRPassword,
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      retypedPassword = val;
                                    });
                                  },
                                ),
                              ),
                              ElevatedButton(
                                child: Text(
                                  AppStrings.REGISTER_SIGNUP,
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                            email.trim(), password.trim());
                                    if (result == null) {
                                      _showMyDialog();
                                    }
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
                    Text(
                      AppStrings.REGISTER_WITH_SOCIAL,
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
