import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_diary/domain/core/value_objects.dart';
import 'package:health_diary/domain/user/user.dart' as domain;

extension FireBaseUserDomainX on User {
  domain.User toDomain() {
    return domain.User(
      id: UniqueId.fromUniqueString(uid),
    );
  }
}
