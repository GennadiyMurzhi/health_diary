import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
abstract class AuthFailure with _$AuthFailure {
  const factory AuthFailure.emailAlreadyInUsed() = EmailAlreadyInUsed;

  const factory AuthFailure.invalidEmailAndPasswordCombination() = InvalidEmailAndPasswordCombination;
}
