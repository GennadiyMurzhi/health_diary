import 'package:dartz/dartz.dart';
import 'package:health_diary/domain/core/failures.dart';

Either<AuthValueFailure<String>, String> validateName(String input) {
  if (RegExp(r"""\W|\d""").hasMatch(input)) {
    return left(AuthValueFailure<String>.nameContainsOtherThen(failedValue: input));
  } else {
    return _regExpValidate(
      input: input,
      regex: r"""[A-Z][a-z]*""",
      failure: AuthValueFailure<String>.wrongName(failedValue: input),
    );
  }
}

Either<AuthValueFailure<String>, String> validateSurname(String input) {
  return _regExpValidate(
    input: input,
    regex: r"""[A-Z][a-z]*""",
    failure: AuthValueFailure<String>.wrongSurname(failedValue: input),
  );
}

Either<AuthValueFailure<String>, String> validateAge(String input) {
  final age = int.tryParse(input);
  if (age == null) {
    return left(
        AuthValueFailure<String>.unacceptableAge(failedValue: 'String have an unexpected format. String: $input'));
  } else if (age < 18) {
    return left(AuthValueFailure<String>.unacceptableAge(failedValue: 'The entered age is less than 18. Age: $input'));
  } else {
    return right(input);
  }
}

Either<AuthValueFailure<String>, String> validateEmailAddress(String input) {
  return _regExpValidate(
    input: input,
    regex: r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""",
    failure: AuthValueFailure<String>.invalidEmail(failedValue: input),
  );
}

Either<AuthValueFailure<String>, String> validatePassword(String input) {
  if (input.length >= 6) {
    return right(input);
  } else {
    return left(AuthValueFailure<String>.shortPassword(failedValue: input));
  }
}

Either<AuthValueFailure<String>, String> _regExpValidate({
  required String input,
  required String regex,
  required AuthValueFailure<String> failure,
}) {
  if (RegExp(regex).hasMatch(input)) {
    return right(input);
  } else {
    return left(failure);
  }
}
