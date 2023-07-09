part of 'user_info_form_cubit.dart';

@freezed
class UserInfoFormState with _$UserInfoFormState {
  const factory UserInfoFormState({
    required UserInfo userInfo,
    required bool isEqualInitialUserInfo,
    required bool showErrorMessage,
    required bool isSaving,
    required Option<Either<UserFailure, Unit>> userFailureOrSuccessOption,
  }) = _UserInfoFormState;

  factory UserInfoFormState.initial() => UserInfoFormState(
        userInfo: UserInfo.empty(),
        isEqualInitialUserInfo: true,
        showErrorMessage: false,
        isSaving: false,
        userFailureOrSuccessOption: none(),
      );
}
