import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health_diary/domain/diary/diary.dart';
import 'package:health_diary/domain/diary/diary_failure.dart';

part 'diary_form_state.dart';
part 'diary_form_cubit.freezed.dart';

class DiaryFormCubit extends Cubit<DiaryFormState> {
  DiaryFormCubit() : super(const DiaryFormState.initial());
}
