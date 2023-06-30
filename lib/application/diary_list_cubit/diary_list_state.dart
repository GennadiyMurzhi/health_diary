part of 'diary_list_cubit.dart';

@freezed
abstract class DiaryListState with _$DiaryListState {
  const factory DiaryListState({
    required List<DiaryPreInfo> diaryPreInfoList,
}) = _DiaryListState;
}
