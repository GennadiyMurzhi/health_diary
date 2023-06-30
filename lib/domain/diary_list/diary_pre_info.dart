import 'package:freezed_annotation/freezed_annotation.dart';

part 'diary_pre_info.freezed.dart';

@freezed
class DiaryPreInfo with _$DiaryPreInfo {
  factory DiaryPreInfo({
    required String diaryName,
    required DateTime startIt,
    required DateTime earlyEntry,
    required bool stopped,
  }) = _DiaryPreInfo;
}
