import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_diary/domain/core/value_objects.dart';
import 'package:health_diary/domain/user/i_user_repository.dart';
import 'package:health_diary/domain/user/user.dart';
import 'package:health_diary/domain/user/user_failure.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'user_info_form_state.dart';

part 'user_info_form_cubit.freezed.dart';

@injectable
class UserInfoFormCubit extends Cubit<UserInfoFormState> {
  UserInfoFormCubit(this._userRepository) : super(UserInfoFormState.initial());

  final IUserRepository _userRepository;
  late final UserInfo _initialUserInfo;

  void init(UserInfo initialUserInfo) {
    _initialUserInfo = initialUserInfo;
    emit(
      state.copyWith(
        userInfo: initialUserInfo,
      ),
    );
  }

  void onChangedName(String name) {
    final UserInfo newUserInfo = state.userInfo.copyWith(name: Name(name),);

    emit(
      state.copyWith(
        userInfo: newUserInfo,
        isEqualInitialUserInfo: _initialUserInfo == newUserInfo,
        userFailureOrSuccessOption: none(),
      ),
    );
  }

  void onChangedSurname(String surname) {
    final UserInfo newUserInfo = state.userInfo.copyWith(surname: Name(surname),);

    emit(
      state.copyWith(
        userInfo: newUserInfo,
        isEqualInitialUserInfo: _initialUserInfo == newUserInfo,
        userFailureOrSuccessOption: none(),
      ),
    );
  }

  void onChangedAge(String age) {
    final UserInfo newUserInfo = state.userInfo.copyWith(age: Age(age),);

    emit(
      state.copyWith(
        userInfo: newUserInfo,
        isEqualInitialUserInfo: _initialUserInfo == newUserInfo,
        userFailureOrSuccessOption: none(),
      ),
    );
  }

  Future<void> saveUserInfoOnTheServer() async {
    Either<UserFailure, Unit>? failuresOrSuccess;

    if (state.userInfo.name.isValid() && state.userInfo.surname.isValid() && state.userInfo.age.isValid()) {
      emit(
        state.copyWith(
          isSaving: true,
          userFailureOrSuccessOption: none(),
        ),
      );

      failuresOrSuccess = await _userRepository.saveUserInfo(
        name: state.userInfo.name.getOrCrash(),
        surname: state.userInfo.surname.getOrCrash(),
        age: state.userInfo.age.getOrCrash(),
      );
    }

    emit(
      state.copyWith(
        isSaving: false,
        showErrorMessage: true,
        userFailureOrSuccessOption: optionOf(failuresOrSuccess),
      ),
    );
  }
}
