import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:health_diary/domain/core/failures.dart';
import 'package:health_diary/domain/core/value_objects.dart';
import 'package:health_diary/domain/core/value_validators.dart';

/// Value object for contains Diary Name
@immutable
class DiaryName extends ValueObject<String> {
  /// Constructor which validate Diary Name
  factory DiaryName(String input) {
    return DiaryName._(
      validateMaxStringLength(input, 50),
    );
  }

  const DiaryName._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

/// Value object for contains Diary Description
@immutable
class DiaryDescription extends ValueObject<String> {
  /// Constructor which validate Diary Description
  factory DiaryDescription(String input) {
    return DiaryDescription._(
      validateMaxStringLength(input, 200),
    );
  }

  const DiaryDescription._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

/// Value object for contains Attribute Name
@immutable
class AttributeName extends ValueObject<String> {
  /// Constructor which validate Attribute Name
  factory AttributeName(String input) {
    return AttributeName._(
      validateMaxStringLength(input, 20),
    );
  }

  const AttributeName._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

/// Value object for contains Unit Name
@immutable
class UnitName extends ValueObject<String> {
  /// Constructor which validate Unit Name
  factory UnitName(String input) {
    return UnitName._(
      validateMaxStringLength(input, 10),
    );
  }

  const UnitName._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

/// Value object for contains Point containing the time of data transmission
@immutable
class Point extends ValueObject<DateTime> {
  /// Constructor which validate Point
  factory Point(DateTime input) {
    return Point._(
      validateDayDateTime(input),
    );
  }

  const Point._(this.value);

  @override
  final Either<ValueFailure<DateTime>, DateTime> value;
}

/// Value object which contains data attribute Input and which validate in what range should be
@immutable
class Input extends ValueObject<double> {
  /// Constructor which validate Point
  factory Input(double input, double minInput, double maxInput) {
    return Input._(
      validateRange(input, minInput, maxInput),
    );
  }

  const Input._(this.value);

  @override
  final Either<ValueFailure<double>, double> value;
}
