import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confesseja/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StreamUser {
  final FirebaseUser firebaseUser;
  StreamUser(this.firebaseUser);

  Stream<User> get user {
    return Firestore.instance.collection('users').document(firebaseUser.uid).snapshots().map((event) {
      if(event.exists && event.data != null){
        User user = User(accountType: event.data['account_type']);
        if(event.data.containsKey('display_name')) user.displayName = event.data['display_name'];
        if(event.data.containsKey('photo_url')) user.photoUrl = event.data['photo_url'];
        if(event.data.containsKey('profile_step_confirmation')) user.profileStepConfirmation = event.data['profile_step_confirmation'];
        return user;
      } else {
        return null;
      }
    });
  }
}