import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:health_diary/domain/user/i_user_repository.dart';
import 'package:health_diary/domain/user/user_failure.dart';
import 'package:injectable/injectable.dart';
import 'package:health_diary/data/user/user.dart';
import 'package:health_diary/domain/user/user.dart' as domain;
import 'package:health_diary/data/core/firestore_helpers.dart';

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  UserRepository(this._firebaseFirestore);

  final FirebaseFirestore _firebaseFirestore;

  @override
  Future<Either<UserFailure, domain.UserInfo>> getUserInfo() async {
    try {
      final DocumentReference<Object?> userDocumentReference = await _firebaseFirestore.userDocument();
      final DocumentSnapshot<Object?> userDocument = await userDocumentReference.get();

      if (userDocument.exists) {
        return right(UserInfoData.fromFirestore(userDocument).toDomain());
      } else {
        return left(const UserFailure.userHasNotData());
      }
    } on PlatformException catch (e) {
      if (e.code == 'NOT_FOUND') {
        return left(const UserFailure.userHasNotData());
      } else {
        return left(const UserFailure.serverError());
      }
    }
  }

  @override
  Future<Either<UserFailure, Unit>> saveUserInfo({
    required String name,
    required String surname,
    required int age,
  }) async {
    try {
      final DocumentReference<Object?> userDoc = await _firebaseFirestore.userDocument();

      await userDoc.set({
        'name': name,
        'surname': surname,
        'age': age,
      });

      return right(unit);
    } catch (e) {
      return left(const UserFailure.serverError());
    }
  }
}
