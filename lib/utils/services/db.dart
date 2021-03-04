import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Db {
  static Values values = const Values();
  static Service service = const Service();
}

class Service {
  const Service();

  static final CollectionReference _users = Firestore.instance
      .collection(Db.values.userCollection.collection_reference);
  static final CollectionReference _profileToConfirm = Firestore.instance
      .collection(Db.values.profileToConfirmCollection.collection_reference);

  void uploadUserToDb(FirebaseUser user) {
    _users.document(user.uid).setData({
      Db.values.userCollection.profile_step_confirmation_field:
      Db.values.profileStepConfirmation.incompleto,
      Db.values.userCollection.creation_date_field:
      DateTime.now().toIso8601String()
    }, merge: true);
  }

  Future<DocumentSnapshot> getUser(FirebaseUser firebaseUser) {
    return _users.document(firebaseUser.uid).get();
  }

  void sendIgrejaProfileToConfirmation(FirebaseUser user, String name,
      String address, String phone, String email) {
    UserCollection userCollection = Db.values.userCollection;
    ProfileStepConfirmationCollection profileStepConfirmationCollection = Db.values.profileStepConfirmation;
    ProfileToConfirmCollection profileToConfirmCollection = Db.values.profileToConfirmCollection;
    _profileToConfirm.document(user.uid).setData({
      profileToConfirmCollection.user_id_field: user.uid,
      profileToConfirmCollection.date_field: DateTime.now().toIso8601String()
    }, merge: true).whenComplete(() {
      _users.document(user.uid)
          .setData({
        userCollection.name_field: name,
        userCollection.address_field: address,
        userCollection.phone_field: phone,
        userCollection.email_field: email,
        userCollection.profile_step_confirmation_field: profileStepConfirmationCollection.a_confirmar
      }, merge: true);
    });
  }

  void sendConfessorProfileToConfirmation(FirebaseUser user, String name,
      DateTime birthdate, DateTime orderdate, String order, String email) {
    UserCollection userCollection = Db.values.userCollection;
    ProfileStepConfirmationCollection profileStepConfirmationCollection = Db.values.profileStepConfirmation;
    ProfileToConfirmCollection profileToConfirmCollection = Db.values.profileToConfirmCollection;
    _profileToConfirm.document(user.uid)
        .setData({
      profileToConfirmCollection.user_id_field: user.uid,
      profileToConfirmCollection.date_field: DateTime.now().toIso8601String()
    }, merge: true).whenComplete(() {
      Firestore.instance
          .collection(Db.values.userCollection.collection_reference)
          .document(user.uid)
          .setData({
        userCollection.name_field: name,
        userCollection.birthdate_field: birthdate.toIso8601String(),
        userCollection.orderdate_field: orderdate.toIso8601String(),
        userCollection.order_field: order,
        userCollection.email_field: email,
        userCollection.profile_step_confirmation_field: profileStepConfirmationCollection.a_confirmar
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

  String get collection_reference => 'users';

  String get creation_date_field => 'created_at';

  String get account_type_field => 'account_type';

  String get profile_step_confirmation_field =>
      Db.values.profileStepConfirmation.field;

  String get name_field => 'name';
  String  get address_field => 'address';
  String get phone_field => 'phone';
  String get email_field => 'email';
  String get fullname_field => 'fullname';
  String get birthdate_field => 'birthdate';
  String get orderdate_field => 'orderdate';
  String get order_field => 'order';
}

class ProfileToConfirmCollection {
  const ProfileToConfirmCollection();

  String get collection_reference => 'profile_complete';

  String get user_id_field => 'account';

  String get date_field => 'date';
}

class AccountTypeCollection {
  const AccountTypeCollection();

  String get filed => 'account_type';

  int get penitente => 0;

  int get igreja => 1;

  int get confessor => 2;

  int get admin => 42;
}

class ProfileStepConfirmationCollection {
  const ProfileStepConfirmationCollection();

  String get field => 'profile_step_confirmation';

  int get incompleto => 0;

  int get a_confirmar => 1;

  int get confirmado => 2;
}
