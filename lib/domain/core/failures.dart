import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.auth(AuthValueFailure<T> f) = _Auth<T>;
}

@freezed
abstract class AuthValueFailure<T> with _$AuthValueFailure<T> {
  const factory AuthValueFailure.wrongName({
    required String failedValue,
  }) = WrongName<T>;

  const factory AuthValueFailure.nameContainsOtherThen({
    required String failedValue,
  }) = NameContainsOtherThen<T>;

  const factory AuthValueFailure.wrongSurname({
    required String failedValue,
  }) = WrongSurname<T>;

  const factory AuthValueFailure.unacceptableAge({
    required String failedValue,
  }) = UnacceptableAge<T>;

  const factory AuthValueFailure.invalidEmail({
    required String failedValue,
  }) = InvalidEmail<T>;

  const factory AuthValueFailure.shortPassword({
    required String failedValue,
  }) = ShortPassword<T>;
}
