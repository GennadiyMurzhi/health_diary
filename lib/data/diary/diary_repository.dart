import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:health_diary/data/core/firestore_helpers.dart';
import 'package:health_diary/data/diary/diary.dart';
import 'package:health_diary/domain/diary/diary.dart';
import 'package:health_diary/domain/diary/diary_failure.dart';
import 'package:health_diary/domain/diary/i_diary_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:rxdart/rxdart.dart';

/// Implementation diary repository with using Firebase
@LazySingleton(as: IDiaryRepository)
class DiaryRepository implements IDiaryRepository {
  /// Need pass firestore to use cloud server Firebase
  DiaryRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Stream<Either<DiaryFailure, KtList<Diary>>> watchAll() async* {
    final DocumentReference<Object?> userDocument = await _firestore.userDocument();
    yield* userDocument.diariesCollection
        .orderBy('serverTimeStamp', descending: true)
        .snapshots()
        .map(
          (QuerySnapshot<Object?> snapshot) => right<DiaryFailure, KtList<Diary>>(
            snapshot.docs
                .map((QueryDocumentSnapshot<Object?> doc) => DiaryDto.fromFirestore(doc).toDomain())
                .toImmutableList(),
          ),
        )
        .onErrorReturnWith((Object e, StackTrace stackTrace) {
      if (e is FirebaseException && e.message != null && e.message!.contains('PERMISSION_DENIED')) {
        return left(const DiaryFailure.insufficientPermission());
      } else {
        return left(const DiaryFailure.unexpected());
      }
    });
  }

  @override
  Future<Either<DiaryFailure, Unit>> create(Diary diary) async {
    try {
      final DocumentReference<Object?> userDocument = await _firestore.userDocument();
      final DiaryDto diaryDto = DiaryDto.fromDomain(diary);

      await userDocument.diariesCollection.doc(diaryDto.id).set(diaryDto.toJson());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.message != null && e.message!.contains('PERMISSION_DENIED')) {
        return left(const DiaryFailure.insufficientPermission());
      } else {
        return left(const DiaryFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<DiaryFailure, Unit>> update(Diary diary) async {
    try {
      final DocumentReference<Object?> userDocument = await _firestore.userDocument();
      final DiaryDto diaryDto = DiaryDto.fromDomain(diary);

      await userDocument.diariesCollection.doc(diaryDto.id).update(diaryDto.toJson());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.message != null) {
        if (e.message!.contains('PERMISSION_DENIED')) {
          return left(const DiaryFailure.insufficientPermission());
        } else if (e.message!.contains('NOT_FOUND')) {
          return left(const DiaryFailure.unableToUpdate());
        }
      }
      return left(const DiaryFailure.unexpected());
    }
  }

  @override
  Future<Either<DiaryFailure, Unit>> delete(Diary diary) async {
    try {
      final DocumentReference<Object?> userDocument = await _firestore.userDocument();
      final String diaryId = diary.id.getOrCrash();

      await userDocument.diariesCollection.doc(diaryId).delete();

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.message != null) {
        if (e.message!.contains('PERMISSION_DENIED')) {
          return left(const DiaryFailure.insufficientPermission());
        } else if (e.message!.contains('NOT_FOUND')) {
          return left(const DiaryFailure.unableToUpdate());
        }
      }
      return left(const DiaryFailure.unexpected());
    }
  }
}
