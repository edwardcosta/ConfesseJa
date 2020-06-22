import 'package:confesseja/res/strings.dart';
import 'package:confesseja/utils/services/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:confesseja/res/colors.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimaryColor,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Card(
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            validator: (val) {
                              if(val.isEmpty) return AppStrings.REGISTER_EMPTY;
                              if(!EmailValidator.validate(val)) return AppStrings.REGISTER_INVALID_EMAIL;
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
                                  left: 15, bottom: 11, top: 11, right: 15),
                            ),
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Card(
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            validator: (val) {
                              if(val.isEmpty) return AppStrings.REGISTER_EMPTY;
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
                                  left: 15, bottom: 11, top: 11, right: 15),
                            ),
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        RaisedButton(
                          color: AppColors.secondaryColor,
                          child: Text(
                            AppStrings.REGISTER_LOGIN,
                            style: TextStyle(
                              color: AppColors.iconTextColor,
                            ),
                          ),
                          onPressed: () async {
                            print(email);
                            print(password);
                            if (_formKey.currentState.validate()) {
                              dynamic result = _auth.login(email.trim(), password.trim());
                              if (result == null) {
                                setState(() {
                                  error = AppStrings.REGISTER_LOGIN_ERROR;
                                });
                              }
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red),
              ),
              FlatButton(
                child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Text(
                    AppStrings.REGISTER_NOT_REGISTERED,
                    style: TextStyle(color: AppColors.contentTextColor),
                  ),
                  Text(' '),
                  Text(AppStrings.REGISTER_GOTO_SIGNUP,
                      style: TextStyle(
                        color: AppColors.titleTextColor,
                        fontWeight: FontWeight.bold,
                      )),
                ]),
                onPressed: () {
                  widget.toggleView();
                },
              ),
              FlatButton(
                child: Text(
                  AppStrings.REGISTER_PASSWORD_FORGOT,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
