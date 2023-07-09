import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_diary/application/user/user_info_cubit/user_info_cubit.dart';
import 'package:health_diary/domain/auth/i_auth_facade.dart';
import 'package:health_diary/domain/auth/value_objects.dart';
import 'package:health_diary/domain/core/failures.dart';
import 'package:health_diary/domain/core/value_objects.dart';
import 'package:health_diary/domain/user/i_user_repository.dart';
import 'package:health_diary/domain/user/user.dart';
import 'package:health_diary/domain/user/user_failure.dart';
import 'package:health_diary/injection.dart';
import 'package:injectable/injectable.dart';

part 'auth_form_state.dart';

part 'auth_form_cubit.freezed.dart';

@injectable
class AuthFormCubit extends Cubit<AuthFormState> {
  AuthFormCubit(this._authFacade, this._userRepository) : super(AuthFormState.initialSignUp());

  final IAuthFacade _authFacade;
  final IUserRepository _userRepository;

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

    final Either<Failure, Unit> failuresOrSuccess = await _authFacade.signInWithGoogle();

    if (failuresOrSuccess.isLeft()) {
      emit(
        state.copyWith(
          isSubmitting: false,
          authFailureOrSuccessOption: some(failuresOrSuccess),
        ),
      );
    } else {
      final Either<UserFailure, UserInfo> userInfoOrFailure = await _userRepository.getUserInfo();
      userInfoOrFailure.fold(
        (UserFailure userFailure) {
          final Failure failure = Failure.user(userFailure);

          emit(
            state.copyWith(
              isSubmitting: false,
              authFailureOrSuccessOption: some(left(failure)),
            ),
          );
        },
        (UserInfo userInfo) {
          getIt<UserInfoCubit>().setUserInfo(userInfo);

          emit(
            state.copyWith(
              isSubmitting: false,
              authFailureOrSuccessOption: some(right(unit)),
            ),
          );
        },
      );
    }
  }

  void doNotHaveAnAccountYetPressed() {
    emit(AuthFormState.initialSignUp());
  }

  void alreadyHaveAnAccountPressed() {
    emit(AuthFormState.initialSignIn());
  }
}
