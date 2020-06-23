import 'package:confesseja/res/colors.dart';
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
  String error = '';

  final RegExp hasUppercase = new RegExp('[A-Z]');
  final RegExp hasLowercase = new RegExp('[a-z]');
  final RegExp hasNumber = new RegExp('[0-9]');
  final RegExp hasSymbol = new RegExp('[!@#\$&*~]');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimaryColor,
      body: Stack(children: <Widget>[
        Positioned(
          top: MediaQuery.of(context).padding.top,
          child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: AppColors.iconTextColor,
              onPressed: () {
                widget.toggleView();
              }),
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
                                if (val.isEmpty) return AppStrings.REGISTER_EMPTY;
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
                              obscureText: true,
                              validator: (val) {
                                if (val.isEmpty) return AppStrings.REGISTER_EMPTY;
                                if (val.length < 6)
                                  return AppStrings.REGISTER_PASSWORD_LENGTH;
                                if (!hasUppercase.hasMatch(val))
                                  return AppStrings.REGISTER_PASSWORD_UPPERCASE;
                                if (!hasLowercase.hasMatch(val))
                                  return AppStrings.REGISTER_PASSWORD_LOWERCASE;
                                if (!hasNumber.hasMatch(val))
                                  return AppStrings.REGISTER_PASSWORD_NUMBER;
                                if (!hasSymbol.hasMatch(val))
                                  return AppStrings.REGISTER_PASSWORD_SYMBOL;
                                return null;
                              },
                              decoration: InputDecoration(
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
                          Card(
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextFormField(
                              obscureText: true,
                              validator: (val) {
                                if (val.isEmpty) return AppStrings.REGISTER_EMPTY;
                                if (val != password) return AppStrings.REGISTER_PASSWORD_MATCH;
                                if (val.length < 6)
                                  return AppStrings.REGISTER_PASSWORD_LENGTH;
                                if (!hasUppercase.hasMatch(val))
                                  return AppStrings.REGISTER_PASSWORD_UPPERCASE;
                                if (!hasLowercase.hasMatch(val))
                                  return AppStrings.REGISTER_PASSWORD_LOWERCASE;
                                if (!hasNumber.hasMatch(val))
                                  return AppStrings.REGISTER_PASSWORD_NUMBER;
                                if (!hasSymbol.hasMatch(val))
                                  return AppStrings.REGISTER_PASSWORD_SYMBOL;
                                return null;
                              },
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                labelText: AppStrings.REGISTER_RETYPE_PASSWORD,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  retypedPassword = val;
                                });
                              },
                            ),
                          ),
                          RaisedButton(
                            color: AppColors.secondaryColor,
                            child: Text(
                              AppStrings.REGISTER_SIGNUP,
                              style: TextStyle(
                                color: AppColors.iconTextColor,
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email.trim(), password.trim());
                                if(result == null){
                                  setState(() {
                                    error =  AppStrings.REGISTER_SIGNUP_ERROR;
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
                SizedBox(height: 20.0,),
                Text(error, style: TextStyle(color: Colors.red),),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
