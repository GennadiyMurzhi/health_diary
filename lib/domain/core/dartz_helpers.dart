import 'package:dartz/dartz.dart';

/// Extension for easy retrieval of the Either part
extension EitherHelpers<L, R> on Either<L, R> {
  /// Use this method if Either contains a Right part
  R asRight() => (this as Right).value as R;

  /// Use this method if Either contains a Left part
  L asLeft() => (this as Left).value as L;
}
