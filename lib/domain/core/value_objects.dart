import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:health_diary/domain/core/error.dart';
import 'package:health_diary/domain/core/failures.dart';
import 'package:uuid/uuid.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<AuthValueFailure<T>, T> get value;

  T getOrCrash() {
    return value.fold((l) => throw UnexpectedValueError(l), id);
  }

  bool isValid() => value.isRight();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is ValueObject<T> &&
              runtimeType == other.runtimeType &&
              value == other.value);

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'Value{' + ' value: $value,' + '}';
  }

}


@immutable
class UniqueId extends ValueObject<String> {
  @override
  final Either<AuthValueFailure<String>, String> value;

  factory UniqueId() {
    return UniqueId._(
      right(const Uuid().v1()),
    );
  }

  factory UniqueId.fromUniqueString(String uniqueId) {
    return UniqueId._(
      right(uniqueId),
    );
  }

  const UniqueId._(this.value);
}
