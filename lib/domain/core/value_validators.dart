import 'package:dartz/dartz.dart';
import 'package:health_diary/domain/core/failures.dart';

/// Validate input range
Either<ValueFailure<double>, double> validateRange(double input, double min, double max) {
  if (min < input && input < max) {
    return right(input);
  } else {
    return left(
      ValueFailure<double>.missesTheGap(
        failedValue: input,
        min: min,
        max: max,
      ),
    );
  }
}

/// Checks that the DateTime is not greater than a day
Either<ValueFailure<DateTime>, DateTime> validateDayDateTime(DateTime input) {
  if (DateTime(0, 0, 0, 24).isAfter(input)) {
    return right(input);
  } else {
    return left(ValueFailure<DateTime>.longDateTime(failedValue: input));
  }
}

/// Validate string length for value object(Diary Name, Attribute Name, etc)
Either<ValueFailure<String>, String> validateMaxStringLength(String input, int maxLength) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(ValueFailure<String>.longString(failedValue: input));
  }
}

/// Validate User Name string for value object
Either<ValueFailure<String>, String> validateName(String input) {
  if (RegExp(r"""\W|\d""").hasMatch(input)) {
    return left(ValueFailure<String>.nameContainsOtherThen(failedValue: input));
  } else {
    return _regExpValidate(
      input: input,
      regex: r"""[A-Z][a-z]*""",
      failure: ValueFailure<String>.wrongName(failedValue: input),
    );
  }
}

/// Validate age for value object
Either<ValueFailure<int>, int> validateAge(int input) {
  if (input < 18) {
    return left(ValueFailure<int>.unacceptableAge(failedValue: '$input'));
  } else {
    return right(input);
  }
}

/// Validate Email address string for value object
Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  return _regExpValidate(
    input: input,
    regex: r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""",
    failure: ValueFailure<String>.invalidEmail(failedValue: input),
  );
}

/// Validate password string for value object
Either<ValueFailure<String>, String> validatePassword(String input) {
  if (input.length >= 6) {
    return right(input);
  } else {
    return left(ValueFailure<String>.shortPassword(failedValue: input));
  }
}

Either<ValueFailure<String>, String> _regExpValidate({
  required String input,
  required String regex,
  required ValueFailure<String> failure,
}) {
  if (RegExp(regex).hasMatch(input)) {
    return right(input);
  } else {
    return left(failure);
  }
}
