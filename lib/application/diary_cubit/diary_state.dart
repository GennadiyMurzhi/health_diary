part of 'diary_cubit.dart';

@freezed
abstract class DiaryState with _$DiaryState {
  factory DiaryState({
    required Diary diary,
    required bool isPreview,
    required bool isVisualization,
  }) = _DiaryState;
}
