part of 'diary_form_cubit.dart';

/// State for Diary form Cubit
@freezed
abstract class DiaryFormState with _$DiaryFormState {
  /// Main constructor
  factory DiaryFormState({
    required Diary diary,
    required bool showErrorMessages,
    required bool isEditing,
    required bool isSaving,
    required Option<Either<DiaryFailure, Unit>> saveFailureOrSuccessOption,
  }) = _DiaryFormState;

  /// Diary initial state
  factory DiaryFormState.initial() => DiaryFormState(
        diary: Diary.empty(),
        showErrorMessages: false,
        isEditing: false,
        isSaving: false,
        saveFailureOrSuccessOption: none(),
      );
}
