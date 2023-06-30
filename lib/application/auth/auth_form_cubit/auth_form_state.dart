part of 'auth_form_cubit.dart';

@freezed
class AuthFormState with _$AuthFormState {
  const factory AuthFormState({
    Name? name,
    Name? surname,
    Age? age,
    required EmailAddress emailAddress,
    required Password password,
    bool? errorName,
    bool? errorSurname,
    bool? errorAge,
    required bool errorEmailAddress,
    required bool errorPassword,
    required bool showErrorMessage,
    required bool isSubmitting,
    required bool isSignUp,
    required Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
  }) = _AuthFormState;

  factory AuthFormState.initialSignUp() =>
      AuthFormState(
        name: Name(''),
        surname: Name(''),
        age: Age(''),
        emailAddress: EmailAddress(''),
        password: Password(''),
        errorName: false,
        errorSurname: false,
        errorAge: false,
        errorEmailAddress: false,
        errorPassword: false,
        showErrorMessage: false,
        isSubmitting: false,
        isSignUp: true,
        authFailureOrSuccessOption: none(),
      );

  factory AuthFormState.initialSignIn() =>
      AuthFormState(
        emailAddress: EmailAddress(''),
        password: Password(''),
        errorName: false,
        errorSurname: false,
        errorAge: false,
        errorEmailAddress: false,
        errorPassword: false,
        showErrorMessage: false,
        isSubmitting: false,
        isSignUp: false,
        authFailureOrSuccessOption: none(),
      );
}
