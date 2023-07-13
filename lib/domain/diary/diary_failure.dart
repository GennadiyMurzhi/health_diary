import 'package:freezed_annotation/freezed_annotation.dart';

part 'diary_failure.freezed.dart';

@freezed
abstract class DiaryFailure with _$DiaryFailure {
  const factory DiaryFailure.unexpected() = _Unexpected;
  const factory DiaryFailure.insufficientPermission() = _InsufficientPermission;
  const factory DiaryFailure.unableToUpdate() = _UnableToUpdate;
}