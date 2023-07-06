import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_diary/application/user/user_info_cubit/user_info_cubit.dart';
import 'package:health_diary/domain/user/i_user_repository.dart';
import 'package:health_diary/domain/user/user.dart';
import 'package:health_diary/domain/user/user_failure.dart';
import 'package:health_diary/injection.dart';
import 'package:injectable/injectable.dart';

part 'user_state.dart';

part 'user_cubit.freezed.dart';

@lazySingleton
class UserCubit extends Cubit<UserState> {
  UserCubit(this._userRepository) : super(const UserState.initial());

  final IUserRepository _userRepository;

  Future<void> checkUserInfo() async {
    final Either<UserFailure, UserInfo> userInfoOrFailure = await _userRepository.getUserInfo();
    userInfoOrFailure.fold(
      (UserFailure failure) => failure.maybeWhen(
        serverError: () => UserState.loadFailure(failure),
        userHasNotData: () => emit(const UserState.notUserInfo()),
        orElse: () {},
      ),
      (UserInfo userInfo) {
        getIt<UserInfoCubit>().setUserInfo(userInfo);

        emit(const UserState.userInfoExists());
      },
    );
  }
}
