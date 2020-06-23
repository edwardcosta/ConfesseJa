import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confesseja/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StreamUser {
  final FirebaseUser firebaseUser;
  StreamUser(this.firebaseUser);

  Stream<User> get user {
    return Firestore.instance.collection('users').document(firebaseUser.uid).snapshots().map((event) {
      if(event.exists && event.data != null){
        return User(accountType: event.data['account_type']);
      } else {
        return null;
      }
    });
  }
}