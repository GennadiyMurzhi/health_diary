part of 'user_info_cubit.dart';

@freezed
class UserInfoState with _$UserInfoState {
  const factory UserInfoState({
    required UserInfo userInfo,
    required bool isEditing,
    required bool isSaving,
  }) = _UserInfoState;

  factory UserInfoState.initial() => UserInfoState(
        userInfo: UserInfo.empty(),
        isEditing: false,
        isSaving: false,
      );
}
