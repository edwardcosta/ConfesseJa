import 'package:confesseja/res/colors.dart';
import 'package:confesseja/services/auth.dart';
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
  final RegExp hasNumbercase = new RegExp('[0-9]');
  final RegExp hasSymbolcase = new RegExp('[!@#\$&*~]');

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
                                if (val.isEmpty) return 'Campo vazio';
                                if (!EmailValidator.validate(val))
                                  return 'Email inválido';
                                return null;
                              },
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Email',
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
                                if (val.isEmpty) return 'Campo vazio';
                                if (val.length < 6)
                                  return 'Senha deve conter 6 ou mais caracteres';
                                if (!hasUppercase.hasMatch(val))
                                  return 'Senha deve conter ao menos 1 letra maiúscula';
                                if (!hasLowercase.hasMatch(val))
                                  return 'Senha deve conter ao menos 1 letra minúsucla';
                                if (!hasNumbercase.hasMatch(val))
                                  return 'Senha deve conter ao menos 1 número';
                                if (!hasSymbolcase.hasMatch(val))
                                  return 'Senha deve conter ao menos 1 caracter não alfanumérico';
                                return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Senha',
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
                                if (val.isEmpty) return 'Campo vazio';
                                if (val != password) return 'Senhas diferentes';
                                if (val.length < 6)
                                  return 'Senha deve conter 6 ou mais caracteres';
                                if (!hasUppercase.hasMatch(val))
                                  return 'Senha deve conter ao menos 1 letra maiúscula';
                                if (!hasLowercase.hasMatch(val))
                                  return 'Senha deve conter ao menos 1 letra minúsucla';
                                if (!hasNumbercase.hasMatch(val))
                                  return 'Senha deve conter ao menos 1 número';
                                if (!hasSymbolcase.hasMatch(val))
                                  return 'Senha deve conter ao menos 1 caracter não alfanumérico';
                                return null;
                              },
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Reescreva a senha',
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
                              'Cadastrar',
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
                                    error =  'Aconteceu algum erro';
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
