import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confesseja/utils/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateLoginInformation {
  static bool _run = true;

  static void updateLoginInformation(BuildContext context) {
    if (_run) {
      final FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);
      final DocumentReference userField = Firestore.instance
          .collection(Db.values.userCollection.collectionReference)
          .document(firebaseUser.uid);
      userField.snapshots().first.then((value) {
        if (value.exists && value.data != null) {
          if (value.data.containsKey('current_login'))
            userField.setData({'last_login': value.data['current_login']},
                merge: true);
        }
      });
      userField.setData({'current_login': DateTime.now().toIso8601String()},
          merge: true);
    }
    _run = false;
  }
}
