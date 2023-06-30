import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:health_diary/domain/core/failures.dart';
import 'package:health_diary/domain/core/value_objects.dart';
import 'package:health_diary/domain/core/value_validators.dart';

@immutable
class Name extends ValueObject<String>{
  @override
  final Either<AuthValueFailure<String>, String> value;

  factory Name(String input) {
    return Name._(
      validateName(input),
    );
  }

  const Name._(this.value);
}

@immutable
class Surname extends ValueObject<String>{
  @override
  final Either<AuthValueFailure<String>, String> value;

  factory Surname(String input) {
    return Surname._(
      validateSurname(input),
    );
  }

  const Surname._(this.value);
}

@immutable
class Age extends ValueObject<String>{
  @override
  final Either<AuthValueFailure<String>, String> value;

  factory Age(String input) {
    return Age._(
      validateAge(input),
    );
  }

  const Age._(this.value);
}

@immutable
class EmailAddress extends ValueObject<String>{
  @override
  final Either<AuthValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(this.value);
}

@immutable
class Password extends ValueObject<String>{
  @override
  final Either<AuthValueFailure<String>, String> value;

  factory Password(String input) {
    return Password._(
      validatePassword(input),
    );
  }

  const Password._(this.value);
}
