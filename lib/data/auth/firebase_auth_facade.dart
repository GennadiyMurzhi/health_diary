import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_diary/data/auth/firebase_user_mapper.dart';
import 'package:health_diary/domain/auth/auth_failure.dart';
import 'package:health_diary/domain/auth/i_auth_facade.dart';
import 'package:health_diary/domain/auth/value_objects.dart';
import 'package:injectable/injectable.dart';
import 'package:health_diary/domain/user/user.dart' as domain;

@LazySingleton(as: IAuthFacade)
class FirebaseAuthFacade implements IAuthFacade {
  FirebaseAuthFacade(this._firebaseAuth, this._firebaseFirestore, this._googleSignIn);

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final GoogleSignIn _googleSignIn;

  @override
  Future<Either<AuthFailure, Unit>> register({
    required Name name,
    required Name surname,
    required Age age,
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final String nameStr = name.getOrCrash();
    final String surnameStr = surname.getOrCrash();
    final String ageStr = age.getOrCrash();
    final String emailAddressStr = emailAddress.getOrCrash();
    final String passwordStr = password.getOrCrash();

    //TODO: make create user by firebase function with addition data
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddressStr,
        password: passwordStr,
      );
      await _firebaseFirestore.collection('/users').add({
        'user_uid': userCredential.user!.uid,
        'name': nameStr,
        'surname': surnameStr,
        'age': ageStr,
      });

      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        return left(const AuthFailure.emailAlreadyInUsed());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddressStr,
        password: passwordStr,
      );

      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE' || e.code == 'ERROR_USER_NOT_FOUND') {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return left(const AuthFailure.cancelledByUser());
      }

      final GoogleSignInAuthentication googleAuthentication = await googleUser.authentication;

      final OAuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );

      return _firebaseAuth.signInWithCredential(authCredential).then((r) => right(unit));
    } on PlatformException catch (e) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Option<domain.User>> getSignedInUser() async {
    if (_firebaseAuth.currentUser != null) {
      return optionOf(
        _firebaseAuth.currentUser!.toDomain(),
      );
    } else {
      return optionOf(
        null,
      );
    }
  }

  @override
  Future<void> signOut() {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}
