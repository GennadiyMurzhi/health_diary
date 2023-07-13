import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_diary/domain/core/value_objects.dart';
import 'package:health_diary/domain/user/user.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class UserInfoDto with _$UserInfoDto {
  const UserInfoDto._();

  factory UserInfoDto({
    required String name,
    required String surname,
    required int age,
  }) = _UserInfoDto;

  factory UserInfoDto.fromJson(Map<String, dynamic> json) => _$UserInfoDtoFromJson(json);

  factory UserInfoDto.fromFirestore(DocumentSnapshot doc) {
    return UserInfoDto.fromJson(doc.data() as Map<String, dynamic>);
  }

  UserInfoDto fromDomain(UserInfo userInfo) {
    return UserInfoDto(
      name: userInfo.name.getOrCrash(),
      surname: userInfo.surname.getOrCrash(),
      age: userInfo.age.getOrCrash(),
    );
  }

  UserInfo toDomain() {
    return UserInfo(
      name: Name(name),
      surname: Name(surname),
      age: Age.fromInt(age),
    );
  }
}
