import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_diary/domain/auth/auth_failure.dart';
import 'package:health_diary/domain/auth/i_auth_facade.dart';
import 'package:health_diary/domain/auth/value_objects.dart';
import 'package:injectable/injectable.dart';

part 'auth_form_state.dart';

part 'auth_form_cubit.freezed.dart';

@injectable
class AuthFormCubit extends Cubit<AuthFormState> {
  AuthFormCubit(this._authFacade) : super(AuthFormState.initialSignUp());

  final IAuthFacade _authFacade;

  void onChangedName(String name) {
    emit(
      state.copyWith(
        name: Name(name),
        authFailureOrSuccessOption: none(),
      ),
    );
  }

  void onChangedSurname(String surname) {
    emit(
      state.copyWith(
        surname: Name(surname),
        authFailureOrSuccessOption: none(),
      ),
    );
  }

  void onChangedAge(String age) {
    emit(
      state.copyWith(
        age: Age(age),
        authFailureOrSuccessOption: none(),
      ),
    );
  }

  void onChangedEmail(String email) {
    emit(
      state.copyWith(
        emailAddress: EmailAddress(email),
        authFailureOrSuccessOption: none(),
      ),
    );
  }

  void onChangedPassword(String password) {
    emit(
      state.copyWith(
        password: Password(password),
        authFailureOrSuccessOption: none(),
      ),
    );
  }

  void validName() {
    emit(
      state.copyWith(errorName: false),
    );
  }

  void validSurname() {
    emit(
      state.copyWith(errorSurname: false),
    );
  }

  void validAge() {
    emit(
      state.copyWith(errorAge: false),
    );
  }

  void validEmail() {
    emit(
      state.copyWith(errorEmailAddress: false),
    );
  }

  void validPassword() {
    emit(
      state.copyWith(errorPassword: false),
    );
  }

  void noValidName() {
    emit(
      state.copyWith(errorName: true),
    );
  }

  void noValidSurname() {
    emit(
      state.copyWith(errorSurname: true),
    );
  }

  void noValidAge() {
    emit(
      state.copyWith(errorAge: true),
    );
  }

  void noValidEmail() {
    emit(
      state.copyWith(errorEmailAddress: true),
    );
  }

  void noValidPassword() {
    emit(
      state.copyWith(errorPassword: true),
    );
  }

  Future<void> signUpPressed() async {
    Either<AuthFailure, Unit>? failuresOrSuccess;

    final isNameValid = state.name!.isValid();
    final isSurnameValid = state.surname!.isValid();
    final isAgeValid = state.age!.isValid();
    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();

    if (isNameValid && isSurnameValid && isAgeValid && isEmailValid && isPasswordValid) {
      emit(
        state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        ),
      );

      failuresOrSuccess = await _authFacade.register(
        name: state.name!,
        surname: state.surname!,
        age: state.age!,
        emailAddress: state.emailAddress,
        password: state.password,
      );
    }

    emit(
      state.copyWith(
        isSubmitting: false,
        showErrorMessage: true,
        authFailureOrSuccessOption: optionOf(failuresOrSuccess),
      ),
    );
  }

  Future<void> signInPressed() async {
    Either<AuthFailure, Unit>? failuresOrSuccess;

    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();

    if (isEmailValid && isPasswordValid) {
      emit(
        state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        ),
      );

      failuresOrSuccess = await _authFacade.signInWithEmailAndPassword(
        emailAddress: state.emailAddress,
        password: state.password,
      );
    }
    emit(
      state.copyWith(
        isSubmitting: false,
        showErrorMessage: true,
        authFailureOrSuccessOption: optionOf(failuresOrSuccess),
      ),
    );
  }

  Future<void> signInWithGooglePressed() async {
    emit(
      state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      ),
    );

    final failuresOrSuccess = await _authFacade.signInWithGoogle();

    emit(
      state.copyWith(
        isSubmitting: false,
        authFailureOrSuccessOption: some(failuresOrSuccess),
      ),
    );
  }

  void doNotHaveAnAccountYetPressed() {
    emit(AuthFormState.initialSignUp());
  }

  void alreadyHaveAnAccountPressed() {
    emit(AuthFormState.initialSignIn());
  }
}
