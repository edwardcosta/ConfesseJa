import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Db {
  static Values values = const Values();
  static Service service = const Service();
}

class Service {
  const Service();

  static final CollectionReference _users = Firestore.instance
      .collection(Db.values.userCollection.collectionReference);
  static final CollectionReference _profileToConfirm = Firestore.instance
      .collection(Db.values.profileToConfirmCollection.collectionReference);

  void uploadUserToDb(FirebaseUser user) {
    _users.document(user.uid).setData({
      Db.values.userCollection.profileStepConfirmationField:
          Db.values.profileStepConfirmation.incompleto,
      Db.values.userCollection.creationDateField:
          DateTime.now().toIso8601String()
    }, merge: true);
  }

  Future<DocumentSnapshot> getUser(FirebaseUser firebaseUser) {
    return _users.document(firebaseUser.uid).get();
  }

  void sendIgrejaProfileToConfirmation(FirebaseUser user, String name,
      String address, String phone, String email) {
    UserCollection userCollection = Db.values.userCollection;
    ProfileStepConfirmationCollection profileStepConfirmationCollection =
        Db.values.profileStepConfirmation;
    ProfileToConfirmCollection profileToConfirmCollection =
        Db.values.profileToConfirmCollection;
    _profileToConfirm.document(user.uid).setData({
      profileToConfirmCollection.userIdField: user.uid,
      profileToConfirmCollection.dateField: DateTime.now().toIso8601String()
    }, merge: true).whenComplete(() {
      _users.document(user.uid).setData({
        userCollection.nameField: name,
        userCollection.addressField: address,
        userCollection.phoneField: phone,
        userCollection.emailField: email,
        userCollection.profileStepConfirmationField:
            profileStepConfirmationCollection.aConfirmar
      }, merge: true);
    });
  }

  void sendConfessorProfileToConfirmation(FirebaseUser user, String name,
      DateTime birthdate, DateTime orderdate, String order, String email) {
    UserCollection userCollection = Db.values.userCollection;
    ProfileStepConfirmationCollection profileStepConfirmationCollection =
        Db.values.profileStepConfirmation;
    ProfileToConfirmCollection profileToConfirmCollection =
        Db.values.profileToConfirmCollection;
    _profileToConfirm.document(user.uid).setData({
      profileToConfirmCollection.userIdField: user.uid,
      profileToConfirmCollection.dateField: DateTime.now().toIso8601String()
    }, merge: true).whenComplete(() {
      Firestore.instance
          .collection(Db.values.userCollection.collectionReference)
          .document(user.uid)
          .setData({
        userCollection.nameField: name,
        userCollection.birthdateField: birthdate.toIso8601String(),
        userCollection.orderdateField: orderdate.toIso8601String(),
        userCollection.orderField: order,
        userCollection.emailField: email,
        userCollection.profileStepConfirmationField:
            profileStepConfirmationCollection.aConfirmar
      }, merge: true);
    });
  }
}

class Values {
  const Values();

  UserCollection get userCollection => const UserCollection();

  ProfileToConfirmCollection get profileToConfirmCollection =>
      const ProfileToConfirmCollection();

  AccountTypeCollection get accountType => const AccountTypeCollection();

  ProfileStepConfirmationCollection get profileStepConfirmation =>
      const ProfileStepConfirmationCollection();
}

class UserCollection {
  const UserCollection();

  String get collectionReference => 'users';

  String get creationDateField => 'created_at';

  String get accountTypeField => 'account_type';

  String get profileStepConfirmationField =>
      Db.values.profileStepConfirmation.field;

  String get nameField => 'name';
  String get addressField => 'address';
  String get phoneField => 'phone';
  String get emailField => 'email';
  String get fullnameField => 'fullname';
  String get birthdateField => 'birthdate';
  String get orderdateField => 'orderdate';
  String get orderField => 'order';
}

class ProfileToConfirmCollection {
  const ProfileToConfirmCollection();

  String get collectionReference => 'profile_complete';

  String get userIdField => 'account';

  String get dateField => 'date';
}

class AccountTypeCollection {
  const AccountTypeCollection();

  String get field => 'account_type';

  int get penitente => 0;

  int get igreja => 1;

  int get confessor => 2;

  int get admin => 42;
}

class ProfileStepConfirmationCollection {
  const ProfileStepConfirmationCollection();

  String get field => 'profile_step_confirmation';

  int get incompleto => 0;

  int get aConfirmar => 1;

  int get confirmado => 2;
}
