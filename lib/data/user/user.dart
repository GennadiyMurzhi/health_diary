import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_diary/domain/core/value_objects.dart';
import 'package:health_diary/domain/user/user.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class UserInfoData with _$UserInfoData {
  const UserInfoData._();

  factory UserInfoData({
    required String name,
    required String surname,
    required int age,
  }) = _UserInfoData;

  factory UserInfoData.fromJson(Map<String, dynamic> json) => _$UserInfoDataFromJson(json);

  factory UserInfoData.fromFirestore(DocumentSnapshot doc) {
    return UserInfoData.fromJson(doc.data() as Map<String, dynamic>);
  }

  UserInfoData fromDomain(UserInfo userInfo) {
    return UserInfoData(
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
