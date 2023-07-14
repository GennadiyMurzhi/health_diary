import 'package:dartz/dartz.dart';
import 'package:health_diary/domain/diary/diary.dart';
import 'package:health_diary/domain/diary/diary_failure.dart';
import 'package:kt_dart/kt.dart';

/// interface for Diary Repository
abstract class IDiaryRepository {
  /// method to get all Diary
  Stream<Either<DiaryFailure, KtList<Diary>>> watchAll();

  /// method to create a Diary on the server
  Future<Either<DiaryFailure, Unit>> create(Diary diary);

  /// method to update a Diary on the server
  Future<Either<DiaryFailure, Unit>> update(Diary diary);

  /// method to delete a Diary on the server
  Future<Either<DiaryFailure, Unit>> delete(Diary diary);
}
