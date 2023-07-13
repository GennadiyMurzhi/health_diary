import 'package:dartz/dartz.dart';
import 'package:health_diary/domain/diary/diary.dart';
import 'package:health_diary/domain/diary/diary_failure.dart';

abstract class IDiaryRepository {
  Stream<Either<DiaryFailure, List<Diary>>> watchAll();
}
