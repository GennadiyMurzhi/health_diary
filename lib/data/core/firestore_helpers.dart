import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:health_diary/domain/auth/i_auth_facade.dart';
import 'package:health_diary/domain/core/error.dart';
import 'package:health_diary/domain/user/user.dart' as domain;
import 'package:health_diary/injection.dart';

extension FirestoreX on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final Option<domain.User> userOption = await getIt<IAuthFacade>().getSignedInUser();
    final domain.User user = userOption.getOrElse(() => throw NotAuthenticatedError());

    return FirebaseFirestore.instance.usersCollection.doc(user.id.getOrCrash());
  }

  CollectionReference get usersCollection => collection('/users');

  CollectionReference get diariesCollection => collection('/diaries');
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference get usersCollection => collection('/users');

  CollectionReference get diariesCollection => collection('/diaries');
}
