import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_diary/data/auth/firebase_user_mapper.dart';
import 'package:health_diary/domain/auth/auth_failure.dart';
import 'package:health_diary/domain/auth/i_auth_facade.dart';
import 'package:health_diary/domain/auth/value_objects.dart';
import 'package:health_diary/domain/core/dartz_helpers.dart';
import 'package:health_diary/domain/core/failures.dart';
import 'package:health_diary/domain/core/value_objects.dart';
import 'package:health_diary/domain/user/i_user_repository.dart';
import 'package:health_diary/domain/user/user_failure.dart';
import 'package:injectable/injectable.dart';
import 'package:health_diary/domain/user/user.dart' as domain;

@LazySingleton(as: IAuthFacade)
class FirebaseAuthFacade implements IAuthFacade {
  FirebaseAuthFacade(this._firebaseAuth, this._googleSignIn, this._userRepository);

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final IUserRepository _userRepository;

  @override
  Future<Either<Failure, Unit>> register({
    required Name name,
    required Name surname,
    required Age age,
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final String nameValue = name.getOrCrash();
    final String surnameValue = surname.getOrCrash();
    final int ageValue = age.getOrCrash();
    final String emailAddressValue = emailAddress.getOrCrash();
    final String passwordValue = password.getOrCrash();

    //TODO: make create user by firebase function with addition data
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddressValue,
        password: passwordValue,
      );

      final Either<UserFailure, Unit> successOrFailure = await _userRepository.saveUserInfo(
        name: nameValue,
        surname: surnameValue,
        age: ageValue,
      );
      if (successOrFailure.isLeft()) {
        return left(Failure.user(successOrFailure.asLeft()));
      } else {
        return right(unit);
      }
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        return left(const Failure.auth(AuthFailure.emailAlreadyInUsed()));
      } else {
        return left(const Failure.serverError());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressValue = emailAddress.getOrCrash();
    final passwordValue = password.getOrCrash();

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddressValue,
        password: passwordValue,
      );

      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE' || e.code == 'ERROR_USER_NOT_FOUND') {
        return left(const Failure.auth(AuthFailure.invalidEmailAndPasswordCombination()));
      } else {
        return left(const Failure.serverError());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return left(const Failure.cancelledByUser());
      }

      final GoogleSignInAuthentication googleAuthentication = await googleUser.authentication;

      final OAuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );

      return _firebaseAuth.signInWithCredential(authCredential).then((r) => right(unit));
    } on PlatformException {
      return left(const Failure.serverError());
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
