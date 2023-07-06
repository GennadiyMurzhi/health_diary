part of 'user_cubit.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = Initial;

  const factory UserState.notUserInfo() = NotUserInfo;

  const factory UserState.userInfoExists() = UserInfoExists;

  const factory UserState.loadFailure(UserFailure failure) = LoadFailure;
}
