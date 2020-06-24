//import 'package:confesseja/res/colors.dart';
import 'package:flutter/material.dart';

class AppStrings {
  static const TextStyle TITLE_STYLE = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      /*color: AppColors.titleTextColor*/);
  static const TextStyle NORMAL_STYLE =
      TextStyle(fontSize: 16, fontWeight: FontWeight.normal);

  static const String APP_NAME = "Confesse já!";

  static const String REGISTER_EMAIL = "Email";
  static const String REGISTER_PASSWORD = "Senha";
  static const String REGISTER_RETYPE_PASSWORD = "Reescreva a senha";
  static const String REGISTER_EMPTY = "Campo vazio";
  static const String REGISTER_INVALID_EMAIL = "Email inválido";
  static const String REGISTER_INVALID_PASSWORD = "Email inválido";
  static const String REGISTER_LOGIN = "Entrar";
  static const String REGISTER_LOGIN_ERROR = "Falha ao fazer login";
  static const String REGISTER_NOT_REGISTERED = "Não tem conta?";
  static const String REGISTER_GOTO_SIGNUP = "Cadastre-se aqui.";
  static const String REGISTER_PASSWORD_FORGOT = "Esqueci minha senha";
  static const String REGISTER_PASSWORD_LENGTH = "Senha deve conter 6 ou mais caracteres";
  static const String REGISTER_PASSWORD_UPPERCASE = "Senha deve conter ao menos 1 letra maiúscula";
  static const String REGISTER_PASSWORD_LOWERCASE = "Senha deve conter ao menos 1 letra minúsucula";
  static const String REGISTER_PASSWORD_NUMBER = "Senha deve conter ao menos 1 número";
  static const String REGISTER_PASSWORD_SYMBOL = "Senha deve conter ao menos 1 caracter não alfanumérico";
  static const String REGISTER_PASSWORD_MATCH = "Senhas diferentes";
  static const String REGISTER_SIGNUP = "Cadastrar";
  static const String REGISTER_SIGNUP_ERROR = "Falha ao criar conta";
  
  static const String PROFILE_CHOOSER_LAITY = "Leigo";
  static const String PROFILE_CHOOSER_PARISH = "Paróquia";
  static const String PROFILE_CHOOSER_PRIEST = "Sacerdote";

  static const String HOME_WELCOME = "Bem Vindo";
}
