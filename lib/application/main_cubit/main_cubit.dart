import 'package:bloc/bloc.dart';
import 'package:health_diary/domain/main/notification.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_cubit.freezed.dart';

part 'main_state.dart';

@injectable
class MainCubit extends Cubit<MainScreenState> {
  MainCubit()
      : super(MainScreenState(
          userName: 'Noah Emma',
          countDiaries: 5,
          notificationList: List.generate(
            5,
            (index) => Notification(
              diaryName: 'Diary Name $index',
              dateInput: DateTime.utc(2022, DateTime.may, 29, 16, 20),
            ),
          ),
        ));
}
