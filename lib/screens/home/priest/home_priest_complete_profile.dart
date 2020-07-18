import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confesseja/res/server_values.dart';
import 'package:confesseja/res/strings.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePriestCompleteProfile extends StatefulWidget {
  @override
  _HomePriestCompleteProfileState createState() =>
      _HomePriestCompleteProfileState();
}

class _HomePriestCompleteProfileState extends State<HomePriestCompleteProfile> {
  final _formKey = GlobalKey<FormState>();

  String fullName;
  DateTime birthdate;
  DateTime orderdate;
  String order;
  String email;

  TextEditingController birthdateTextEditingController =
      TextEditingController();
  TextEditingController orderdateTextEditingController =
      TextEditingController();

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
    final user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(maxWidth: 500),
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Text(
                  AppStrings.PRIEST_COMPLETE_PROFILE_TITLE,
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  AppStrings.PRIEST_COMPLETE_PROFILE,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
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
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                    onChanged: (val) {
                      setState(() {
                        fullName = val;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: InkWell(
                      onTap: () async {
                        final value = await _selectDate(context, birthdate);
                        setState(() {
                          birthdate = value;
                          birthdateTextEditingController.text =
                              value.toString();
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
                                      : Text(
                                          AppStrings.COMPLETE_PROFILE_BIRTHDATE,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  (birthdate == null)
                                      ? Text(
                                          AppStrings.COMPLETE_PROFILE_BIRTHDATE,
                                          textAlign: TextAlign.left,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        )
                                      : Text(
                                          "${birthdate.toLocal()}"
                                              .split(' ')[0]
                                              .replaceAll('-', '/'),
                                          textAlign: TextAlign.left)
                                ])),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: InkWell(
                      onTap: () async {
                        final value = await _selectDate(context, orderdate);
                        setState(() {
                          orderdate = value;
                          orderdateTextEditingController.text =
                              value.toString();
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
                                      : Text(AppStrings.COMPLETE_PROFILE_ORDER,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  (orderdate == null)
                                      ? Text(
                                          AppStrings.COMPLETE_PROFILE_ORDERDATE,
                                          textAlign: TextAlign.left,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        )
                                      : Text(
                                          "${orderdate.toLocal()}"
                                              .split(' ')[0]
                                              .replaceAll('-', '/'),
                                          textAlign: TextAlign.left)
                                ])),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Card(
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
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    ),
                    onChanged: (val) {
                      setState(() {
                        order = val;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
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
                RaisedButton(
                  child: Text('Enviar'),
                  onPressed: () {
                  if (_formKey.currentState.validate() &&
                      birthdate != null &&
                      orderdate != null) {
                    Firestore.instance
                        .collection(ServerValues.PROFILE_TO_CONFIRM_COLLECTION)
                        .document(user.uid)
                        .setData({
                      'account': user.uid,
                      'date': DateTime.now().toIso8601String()
                    }, merge: true).whenComplete(() {
                      Firestore.instance
                          .collection(ServerValues.USERS_COLLECTION)
                          .document(user.uid)
                          .setData({
                        'fullname': fullName,
                        'birthdate': birthdate.toIso8601String(),
                        'orderdate': orderdate.toIso8601String(),
                        'order': order,
                        'email': email,
                        'profile_step_confirmation': 1
                      }, merge: true);
                    });
                  }
                })
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
