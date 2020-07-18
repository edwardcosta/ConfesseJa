import 'package:confesseja/models/user.dart';
import 'package:confesseja/screens/main/perish/home_perish.dart';
import 'package:confesseja/screens/authenticate/complete_profile.dart';
import 'package:confesseja/screens/authenticate/wait_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerishWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    Widget widgetToReturn;
    switch(user.profileStepConfirmation){
      case 0 :
        widgetToReturn = CompleteProfile();
        break;
      case 1:
        widgetToReturn = WaitConfirmation();
        break;
      case 2:
        widgetToReturn = HomePerish();
        break;
      default:
      widgetToReturn = CompleteProfile();
    }
    return widgetToReturn;
  }
}