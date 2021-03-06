import 'package:confesseja/models/user.dart';
import 'package:confesseja/screens/main/home_wrapper.dart';
import 'package:confesseja/screens/profile_chooser/profile_chooser.dart';
import 'package:confesseja/utils/update_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileChooserWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    UpdateLoginInformation.updateLoginInformation(context);
    if (user != null) return HomeWrapper();
    return ProfileChooser();
  }
}
