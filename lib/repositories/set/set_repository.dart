import 'package:advocates/models/app_user.dart';

import '/models/sub_set.dart';
import '/config/paths.dart';
import '/models/failure.dart';
import '/models/set_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/repositories/set/base_set_repo.dart';

class SetRepository extends BaseSetRepo {
  final FirebaseFirestore _firestore;

  SetRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future uploadSubSet(
      {required SubSet? subSet, required SetModel? setModel}) async {
    try {
      if (subSet == null || setModel == null) {
        return;
      }
      print('this runs 2');
      final subSetRef =
          await _firestore.collection(Paths.subsets).add(subSet.toMap());

      final setRef = _firestore.collection(Paths.sets).doc(setModel.setId);
      final setSnap = await setRef.get();
      if (setSnap.exists) {
        // update the set
        setRef.update({
          'subsets': FieldValue.arrayUnion([subSetRef.id])
        });
      } else {
        print('this runs 3');
        // create new set
        setRef.set(setModel.toMap(subSetId: subSetRef.id));
      }
    } catch (error) {
      print('Error uploading subset ${error.toString()}');
      throw const Failure(message: 'Error uploading subset');
    }
  }

  Future<List<SetModel?>> getSets() async {
    try {
      final setsSnaps = await _firestore.collection(Paths.sets).get();

      List<SetModel?> sets = [];

      for (var item in setsSnaps.docs) {
        sets.add(await SetModel.fromDocument(item));
      }

      return sets;
    } catch (error) {
      print('Error getting sets ${error.toString()}');
      throw const Failure(message: 'Error getting sets');
    }
  }

  Future<List<SubSet?>> getSubSets({required String? userId}) async {
    // these subsets are displaying on dashboard
    try {
      if (userId == null) {
        return [];
      }
      List<SubSet?> subSets = [];

      final userSnap =
          await _firestore.collection(Paths.users).doc(userId).get();
      final user = AppUser.fromDocument(userSnap);

      print('formataaa -- ${user?.format}');

      final subSetsSnaps = await _firestore
          .collection(Paths.subsets)
          .where('mediaFormat', isEqualTo: user?.format?.toLowerCase())
          // isEqualTo: user?.format)
          .get();

      print('sub serts -- $subSetsSnaps');

      // return subSetsSnaps.docs.map((doc) => SubSet.fromDocument(doc)).toList();

      for (var item in subSetsSnaps.docs) {
        final subSet = await SubSet.fromDocument(item);
        final userCauses = user?.causes ?? [];
        if (userCauses.contains(subSet?.setModel?.cause)) {
          subSets.add(await SubSet.fromDocument(item));
        }
      }
      return subSets;
    } catch (error) {
      print('Error getting sets ${error.toString()}');
      throw const Failure(message: 'Error getting sets');
    }
  }

  Future<void> deleteSet({required String? setId}) async {
    try {
      await _firestore.collection(Paths.sets).doc(setId).delete();
    } catch (error) {
      print('Error in deleting ${error.toString()}');
      throw const Failure(message: 'Error in deleting set');
    }
  }

  Future<List<SetModel?>> getUserSets({required String? userId}) async {
    try {
      if (userId == null) {
        return [];
      }

      List<SetModel?> sets = [];
      final authorRef = _firestore.collection(Paths.users).doc(userId);
      final setsSnaps = await _firestore
          .collection(Paths.sets)
          .where('author', isEqualTo: authorRef)
          .get();

      for (var item in setsSnaps.docs) {
        sets.add(await SetModel.fromDocument(item));
      }

      return sets;
    } catch (error) {
      print('Error in getting user stats ${error.toString()}');
      throw const Failure(message: 'Error getting sets');
    }
  }

  // increase subset view count

  Future<void> increaseSubSetViews({
    required String? userId,
    required String? subSetId,
  }) async {
    try {
      if (userId == null || subSetId == null) {
        return;
      }

      await _firestore.collection(Paths.subsets).doc(subSetId).update({
        'views': FieldValue.arrayUnion([userId])
      });
    } catch (error) {
      print('Error in increase count ${error.toString()}');
    }
  }

  // like subset

  Future<void> increaseSubSetLikes({
    required String? userId,
    required String? subSetId,
  }) async {
    try {
      if (userId == null || subSetId == null) {
        return;
      }
      await _firestore.collection(Paths.subsets).doc(subSetId).update({
        'likes': FieldValue.arrayUnion([userId])
      });
    } catch (error) {
      print('Error in increase count ${error.toString()}');
    }
  }

  Future<void> increaseSubSetVisits({
    required String? userId,
    required String? subSetId,
  }) async {
    try {
      if (userId == null || subSetId == null) {
        return;
      }
      await _firestore.collection(Paths.subsets).doc(subSetId).update({
        'visits': FieldValue.arrayUnion([userId])
      });
    } catch (error) {
      print('Error in increase count ${error.toString()}');
    }
  }
}

// Future<String?> uploadSet(SetModel? set) async {
  //   try {
  //     if (set == null) {
  //       return null;
  //     }
  //     final docRef = await _firestore.collection(Paths.sets).add(set.toMap());
  //     return docRef.id;
  //   } catch (error) {
  //     print('Error in uploading set ${error.toString()}');
  //     throw const Failure(message: 'Error uploading set');
  //   }
  // }