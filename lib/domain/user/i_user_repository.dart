import 'package:dartz/dartz.dart';
import 'package:health_diary/domain/user/user.dart' as domain;
import 'package:health_diary/domain/user/user_failure.dart';

abstract class IUserRepository {
  Future<Either<UserFailure, domain.UserInfo>> getUserInfo();

  Future<Either<UserFailure, Unit>> saveUserInfo({
    required String name,
    required String surname,
    required int age,
  });
}
