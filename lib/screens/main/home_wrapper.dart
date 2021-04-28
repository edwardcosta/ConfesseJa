import 'package:confesseja/models/user.dart';
import 'package:confesseja/screens/main/admin/home_admin.dart';
import 'package:confesseja/screens/main/laity/home_main.dart';
import 'package:confesseja/screens/main/perish/persih_wrapper.dart';
import 'package:confesseja/screens/main/priest/priest_wrapper.dart';
import 'package:confesseja/screens/profile_chooser/profile_chooser.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

//import 'perish/home_perish.dart';

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

    switch (user.accountType) {
      case 0:
        widgetToReturn = HomeMain();
        break;
      case 1:
        widgetToReturn = PerishWrapper();
        break;
      case 2:
        widgetToReturn = PriestWrapper();
        break;
      case 42:
        widgetToReturn = HomeAdmin();
        break;
      default:
        widgetToReturn = ProfileChooser();
    }

    return StreamProvider<LocationData>.value(
      value: location.onLocationChanged,
      child: widgetToReturn,
    );
  }
}
