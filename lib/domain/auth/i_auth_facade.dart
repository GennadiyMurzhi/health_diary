import 'package:dartz/dartz.dart';
import 'package:health_diary/domain/auth/auth_failure.dart';
import 'package:health_diary/domain/user/user.dart';
import 'package:health_diary/domain/auth/value_objects.dart';

abstract class IAuthFacade{
  Future<Option<User>> getSignedInUser();

  Future<Either<AuthFailure, Unit>> register({
    required Name name,
    required Name surname,
    required Age age,
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithGoogle();

  Future<void> signOut();
}