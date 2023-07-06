import 'package:health_diary/domain/core/failures.dart';

class UnexpectedValueError extends Error {
  UnexpectedValueError(this.valueFailure);

  final ValueFailure valueFailure;

  @override
  String toString() {
    const explanation = 'Encountered a ValueFailure at an unrecoverable point. Terminating.';
    return Error.safeToString('$explanation Failure was: $ValueFailure');
  }
}

class NotAuthenticatedError extends Error {
  NotAuthenticatedError();

  @override
  String toString() {
    const String explanation = 'User is not authenticated';
    return Error.safeToString(explanation);
  }
}
