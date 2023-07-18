import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:health_diary/domain/core/error.dart';
import 'package:health_diary/domain/core/failures.dart';
import 'package:health_diary/domain/core/value_validators.dart';
import 'package:uuid/uuid.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  T getOrCrash() {
    return value.fold((l) => throw UnexpectedValueError(l), id);
  }

  bool isValid() => value.isRight();

  Either<ValueFailure<dynamic>, Unit> get failureOrUnit {
    return value.fold(
          (ValueFailure<T> l) => left(l),
          (T r) => right(unit),
    );
  }

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


  const UniqueId._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;

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
}

@immutable
class Name extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Name(String input) {
    return Name._(
      validateName(input),
    );
  }

  const Name._(this.value);
}

@immutable
class Age extends ValueObject<int> {
  @override
  final Either<ValueFailure<int>, int> value;

  factory Age(String input) {
    final int? inputParse = int.tryParse(input);
    if (inputParse == null) {
      return Age._(
        left(ValueFailure<int>.unacceptableAge(
          failedValue: 'String have an unexpected format. String: $input',
        )),
      );
    } else {
      return Age._(
        validateAge(inputParse),
      );
    }
  }

  factory Age.fromInt(int input) => Age._(
    validateAge(input),
  );

  const Age._(this.value);
}