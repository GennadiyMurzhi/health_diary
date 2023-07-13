import 'package:dartz/dartz.dart';
import 'package:health_diary/domain/diary/diary.dart';
import 'package:health_diary/domain/diary/diary_failure.dart';
import 'package:health_diary/domain/diary/i_diary_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IDiaryRepository)
class DiaryRepository implements IDiaryRepository{
  @override
  Stream<Either<DiaryFailure, List<Diary>>> watchAll() {
    // TODO: implement watchAll
    throw UnimplementedError();
  }

}