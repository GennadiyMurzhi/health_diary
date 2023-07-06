import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_diary/domain/auth/i_auth_facade.dart';
import 'package:health_diary/domain/auth/value_objects.dart';
import 'package:health_diary/domain/core/failures.dart';
import 'package:health_diary/domain/core/value_objects.dart';
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

  Future<void> signUpPressed() async {
    Either<Failure, Unit>? failuresOrSuccess;

    if (state.name!.isValid() &&
        state.surname!.isValid() &&
        state.age!.isValid() &&
        state.emailAddress.isValid() &&
        state.password.isValid()) {
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
    Either<Failure, Unit>? failuresOrSuccess;

    if (state.emailAddress.isValid() && state.password.isValid()) {
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
