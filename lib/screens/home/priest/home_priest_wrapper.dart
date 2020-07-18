import 'package:confesseja/models/user.dart';
import 'package:confesseja/screens/home/priest/home_priest.dart';
import 'package:confesseja/screens/home/priest/home_priest_complete_profile.dart';
import 'package:confesseja/screens/home/priest/home_priest_wait_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePriestWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    Widget widgetToReturn;
    switch(user.profileStepConfirmation){
      case 0 :
        widgetToReturn = HomePriestCompleteProfile();
        break;
      case 1:
        widgetToReturn = HomePriestWaitConfirmation();
        break;
      case 2:
        widgetToReturn = HomePriest();
        break;
      default:
      widgetToReturn = HomePriestCompleteProfile();
    }
    return widgetToReturn;
  }
}