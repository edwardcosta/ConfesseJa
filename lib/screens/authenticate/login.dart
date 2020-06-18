import 'package:confesseja/services/auth.dart';
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

  String email = '';
  String password = '';

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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Card(
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
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
                            decoration: new InputDecoration(
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
                                email = val;
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
                            'Entrar',
                            style: TextStyle(
                              color: AppColors.iconTextColor,
                            ),
                          ),
                          onPressed: () async {
                            
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              FlatButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Não tem conta? ',
                      style: TextStyle(color: AppColors.contentTextColor),
                    ),
                    Text(
                      'Cadastre-se aqui.',
                      style: TextStyle(color: AppColors.titleTextColor, fontWeight: FontWeight.bold,)
                    ),
                  ]
                ),
                onPressed: () {
                  widget.toggleView();
                } ,
              ),
              FlatButton(
                child: Text(
                  'Esqueci minha senha',
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
