import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_diary/domain/auth/value_objects.dart';
import 'package:health_diary/domain/core/value_objects.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required UniqueId id,
  }) = _User;
}

@freezed
abstract class UserInfo with _$UserInfo {
  const factory UserInfo({
    required Name name,
    required Name surname,
    required Age age,
  }) = _UserInfo;

  factory UserInfo.empty() => UserInfo(
        name: Name(''),
        surname: Name(''),
        age: Age(''),
      );
}
