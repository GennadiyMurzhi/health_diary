import 'package:dartz/dartz.dart';
import 'package:health_diary/domain/core/failures.dart';

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

Either<ValueFailure<String>, String> validateSurname(String input) {
  return _regExpValidate(
    input: input,
    regex: r"""[A-Z][a-z]*""",
    failure: ValueFailure<String>.wrongSurname(failedValue: input),
  );
}

Either<ValueFailure<int>, int> validateAge(int input) {
  if (input < 18) {
    return left(ValueFailure<int>.unacceptableAge(failedValue: '$input'));
  } else {
    return right(input);
  }
}

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  return _regExpValidate(
    input: input,
    regex: r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""",
    failure: ValueFailure<String>.invalidEmail(failedValue: input),
  );
}

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
