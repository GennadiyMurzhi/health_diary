part of 'main_cubit.dart';

@freezed
abstract class MainScreenState with _$MainScreenState{
  const factory MainScreenState({
    required String userName,
    required int countDiaries,
    required List<Notification> notificationList,
}) = _MainScreenState;
}

