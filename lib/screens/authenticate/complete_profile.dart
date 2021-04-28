import 'package:confesseja/models/user.dart';
import 'package:confesseja/utils/services/db.dart';
import 'package:confesseja/res/strings.dart';
import 'package:confesseja/utils/services/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompleteProfile extends StatefulWidget {
  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String name;
  DateTime birthdate;
  DateTime orderdate;
  String order;
  String address;
  String phone;
  String email;

  TextEditingController birthdateTextEditingController =
      TextEditingController();
  TextEditingController orderdateTextEditingController =
      TextEditingController();

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sair'),
          content: Text('Deseja realmente sair do aplicativo?'),
          actions: <Widget>[
            TextButton(
              child: Text(AppStrings.YES),
              onPressed: () {
                Navigator.pop(context);
                _auth.logout();
              },
            ),
            TextButton(
              child: Text(AppStrings.NO),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Future<DateTime> _selectDate(
      BuildContext context, DateTime selectedDate) async {
    if (selectedDate == null) selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime.now(),
        locale: Localizations.localeOf(context));
    if (picked != null && picked != selectedDate) return picked;
    return selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<FirebaseUser>(context);
    final user = Provider.of<User>(context);
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
              top: MediaQuery.of(context).padding.top,
              child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    _showMyDialog(context);
                  }),
            ),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 500),
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _buildContent(user, firebaseUser)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContent(User user, FirebaseUser firebaseUser) {
    List<Widget> toReturn = [];
    toReturn.add(Text(
      AppStrings.PROFILE_CHOOSER[user.accountType],
      style: Theme.of(context).textTheme.headline2,
    ));
    toReturn.add(Text(
      AppStrings.COMPLETE_PROFILE_TITLE,
      style: Theme.of(context).textTheme.headline4,
    ));
    toReturn.add(SizedBox(
      height: 10,
    ));
    toReturn.add(Text(
      AppStrings.COMPLETE_PROFILE,
      style: Theme.of(context).textTheme.caption,
    ));
    toReturn.add(SizedBox(
      height: 20,
    ));
    switch (user.accountType) {
      case 1: //IGREJA
        toReturn.add(Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            validator: (val) {
              if (val.isEmpty) return AppStrings.REGISTER_EMPTY;
              return null;
            },
            decoration: new InputDecoration(
              border: InputBorder.none,
              labelText: AppStrings.COMPLETE_PROFILE_PERISHNAME,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            ),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ));
        toReturn.add(SizedBox(
          height: 10,
        ));
        toReturn.add(Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            validator: (val) {
              if (val.isEmpty) return AppStrings.REGISTER_EMPTY;
              return null;
            },
            decoration: new InputDecoration(
              border: InputBorder.none,
              labelText: AppStrings.COMPLETE_PROFILE_ADDRESS,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            ),
            onChanged: (val) {
              setState(() {
                address = val;
              });
            },
          ),
        ));
        toReturn.add(SizedBox(
          height: 10,
        ));
        toReturn.add(Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            validator: (val) {
              if (val.isEmpty) return AppStrings.REGISTER_EMPTY;
              return null;
            },
            decoration: new InputDecoration(
              border: InputBorder.none,
              labelText: AppStrings.COMPLETE_PROFILE_PHONE,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            ),
            onChanged: (val) {
              setState(() {
                phone = val;
              });
            },
          ),
        ));
        break;
      case 2: // CONFESSOR
        toReturn.add(Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            validator: (val) {
              if (val.isEmpty) return AppStrings.REGISTER_EMPTY;
              return null;
            },
            decoration: new InputDecoration(
              border: InputBorder.none,
              labelText: AppStrings.COMPLETE_PROFILE_FULLNAME,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            ),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ));
        toReturn.add(SizedBox(
          height: 10,
        ));
        toReturn.add(Card(
            elevation: 2.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: InkWell(
              onTap: () async {
                final value = await _selectDate(context, birthdate);
                setState(() {
                  birthdate = value;
                  birthdateTextEditingController.text = value.toString();
                });
              },
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          (birthdate == null)
                              ? SizedBox()
                              : Text(AppStrings.COMPLETE_PROFILE_BIRTHDATE,
                                  style: Theme.of(context).textTheme.caption),
                          (orderdate == null)
                              ? SizedBox()
                              : SizedBox(
                                  height: 2,
                                ),
                          (birthdate == null)
                              ? Text(
                                  AppStrings.COMPLETE_PROFILE_BIRTHDATE,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.bodyText2,
                                )
                              : Text(
                                  "${birthdate.toLocal()}"
                                      .split(' ')[0]
                                      .replaceAll('-', '/'),
                                  textAlign: TextAlign.left)
                        ])),
              ),
            )));
        toReturn.add(SizedBox(
          height: 10,
        ));
        toReturn.add(Card(
            elevation: 2.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: InkWell(
              onTap: () async {
                final value = await _selectDate(context, orderdate);
                setState(() {
                  orderdate = value;
                  orderdateTextEditingController.text = value.toString();
                });
              },
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          (orderdate == null)
                              ? SizedBox()
                              : Text(AppStrings.COMPLETE_PROFILE_ORDERDATE,
                                  style: Theme.of(context).textTheme.caption),
                          (orderdate == null)
                              ? SizedBox()
                              : SizedBox(
                                  height: 2,
                                ),
                          (orderdate == null)
                              ? Text(
                                  AppStrings.COMPLETE_PROFILE_ORDERDATE,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.bodyText2,
                                )
                              : Text(
                                  "${orderdate.toLocal()}"
                                      .split(' ')[0]
                                      .replaceAll('-', '/'),
                                  textAlign: TextAlign.left)
                        ])),
              ),
            )));
        toReturn.add(SizedBox(
          height: 10,
        ));
        toReturn.add(Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            validator: (val) {
              if (val.isEmpty) return AppStrings.REGISTER_EMPTY;
              return null;
            },
            decoration: new InputDecoration(
              border: InputBorder.none,
              labelText: AppStrings.COMPLETE_PROFILE_ORDER,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            ),
            onChanged: (val) {
              setState(() {
                order = val;
              });
            },
          ),
        ));
        break;
      default:
    }
    toReturn.add(SizedBox(
      height: 10,
    ));
    toReturn.add(Card(
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
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
        ),
        onChanged: (val) {
          setState(() {
            email = val;
          });
        },
      ),
    ));
    toReturn.add(SizedBox(
      height: 20.0,
    ));
    switch (user.accountType) {
      case 1:
        toReturn.add(ElevatedButton(
            child: Text('Enviar'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Db.service.sendIgrejaProfileToConfirmation(
                    firebaseUser, name, address, phone, email);
              }
            }));
        break;
      case 2:
        toReturn.add(ElevatedButton(
            child: Text('Enviar'),
            onPressed: () {
              if (_formKey.currentState.validate() &&
                  birthdate != null &&
                  orderdate != null) {
                Db.service.sendConfessorProfileToConfirmation(
                    firebaseUser, name, birthdate, orderdate, order, email);
              }
            }));
        break;
    }
    return toReturn;
  }
}
