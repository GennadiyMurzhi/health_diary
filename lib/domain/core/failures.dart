import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_diary/domain/auth/auth_failure.dart';
import 'package:health_diary/domain/user/user_failure.dart';

part 'failures.freezed.dart';

@freezed
abstract class Failure with _$Failure{
  const factory Failure.auth(AuthFailure failure) = _Auth;
  const factory Failure.user(UserFailure failure) = _User;
  const factory Failure.cancelledByUser() = _CancelledByUser;
  const factory Failure.serverError() = _ServerError;
}

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.wrongName({
    required String failedValue,
  }) = WrongName<T>;

  const factory ValueFailure.nameContainsOtherThen({
    required String failedValue,
  }) = NameContainsOtherThen<T>;

  const factory ValueFailure.wrongSurname({
    required String failedValue,
  }) = WrongSurname<T>;

  const factory ValueFailure.unacceptableAge({
    required String failedValue,
  }) = UnacceptableAge<T>;

  const factory ValueFailure.invalidEmail({
    required String failedValue,
  }) = InvalidEmail<T>;

  const factory ValueFailure.shortPassword({
    required String failedValue,
  }) = ShortPassword<T>;

  const factory ValueFailure.longString({
    required String failedValue,
  }) = LongString<T>;

  const factory ValueFailure.longDateTime({
    required DateTime failedValue,
  }) = LongDateTime<T>;

  const factory ValueFailure.missesTheGap({
    required double failedValue,
    required double min,
    required double max,
  }) = MissesTheGap<T>;
}
