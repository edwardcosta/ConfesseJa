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
        if(event.data.containsKey('displayName')) user.displayName = event.data['displayName'];
        if(event.data.containsKey('photoUrl')) user.photoUrl = event.data['photoUrl'];
        return user;
      } else {
        return null;
      }
    });
  }
}