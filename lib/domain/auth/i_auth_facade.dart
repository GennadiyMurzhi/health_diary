import 'package:dartz/dartz.dart';
import 'package:health_diary/domain/core/failures.dart';
import 'package:health_diary/domain/core/value_objects.dart';
import 'package:health_diary/domain/user/user.dart';
import 'package:health_diary/domain/auth/value_objects.dart';

abstract class IAuthFacade {
  Future<Option<User>> getSignedInUser();

  Future<Either<Failure, Unit>> register({
    required Name name,
    required Name surname,
    required Age age,
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<Failure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<Failure, Unit>> signInWithGoogle();

  Future<void> signOut();
}
