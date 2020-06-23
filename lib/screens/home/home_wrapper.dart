import 'package:confesseja/models/user.dart';
import 'package:confesseja/screens/home/home_admin.dart';
import 'package:confesseja/screens/home/home_main.dart';
import 'package:confesseja/screens/home/home_priest.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'home_perish.dart';

class HomeWrapper extends StatefulWidget {
  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  final location = Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  void verifyService() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
  }

  void verifyPermission() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    verifyService();
    verifyPermission();

    final user = Provider.of<User>(context);
    Widget widgetToReturn;

    switch (user.accountType.toInt()) {
      case 0:
        widgetToReturn = HomeMain();
        break;
      case 1:
        widgetToReturn = HomePerish();
        break;
      case 2:
        widgetToReturn = HomePriest();
        break;
      case 42:
        widgetToReturn = HomeMain();
        break;
      default:
        widgetToReturn = HomeMain();
    }

    return StreamProvider<LocationData>.value(
      value: location.onLocationChanged,
      child: widgetToReturn,
    );
  }
}
