import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confesseja/res/server_values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<FirebaseUser> get firebaseUser {
    return _auth.onAuthStateChanged;
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      Firestore.instance
          .collection(ServerValues.USERS_COLLECTION)
          .document(user.uid)
          .setData({
        'profile_step_confirmation': 0,
        'created_at': DateTime.now().toIso8601String()
      }, merge: true);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future loginEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      if (user != null) {
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future loginFacebook() async {
    try {
      final AccessToken accessToken = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final AuthCredential credential =
          FacebookAuthProvider.getCredential(accessToken: accessToken.token);
      // Once signed in, return the UserCredential
      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser user = result.user;
      if (user != null) {
        return user;
      } else {
        return null;
      }
    } on FacebookAuthException catch (e) {
      // handle the FacebookAuthException
      print(e.message);
    } on AuthException catch (e) {
      // handle the FirebaseAuthException
      print(e.message);
    }
    return null;
  }

  Future loginGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser user = result.user;
      if (user != null) {
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future logout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future sendPasswordResetEmail(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
