import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_diary/domain/user/user.dart';
import 'package:injectable/injectable.dart';

part 'user_info_state.dart';

part 'user_info_cubit.freezed.dart';

@lazySingleton
class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit() : super(UserInfoState.initial());

  void setUserInfo(UserInfo userInfo) {
    emit(
      state.copyWith(
        userInfo: userInfo,
      ),
    );
  }

  void switchEditing(bool isEditing) {
    emit(
      state.copyWith(
        isEditing: isEditing,
      ),
    );
  }
}
