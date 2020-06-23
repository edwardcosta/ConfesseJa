import 'package:confesseja/models/user.dart';
import 'package:confesseja/screens/profile_chooser/profile_chooser_wrapper.dart';
import 'package:confesseja/utils/services/stream_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileChooserMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    final _streamUser = StreamUser(user);
    return StreamProvider<User>.value(
      value: _streamUser.user,
      child: ProfileChooserWrapper(),
    );
  }
}
