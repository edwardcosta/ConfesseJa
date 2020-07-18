import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confesseja/res/server_values.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<FirebaseUser> get firebaseUser {
    return _auth.onAuthStateChanged;
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  Future login(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      if(user != null){
        Firestore.instance
          .collection(ServerValues.USERS_COLLECTION)
          .document(user.uid)
          .setData({'profile_step_confirmation':0,'created_at':DateTime.now().toIso8601String()}, merge: true);
        return user;
      } else {
        return null;
      }
    } catch(e){
      print(e.toString());
    }
  }

  Future logout() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

}