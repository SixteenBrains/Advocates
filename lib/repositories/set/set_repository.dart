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
      final subSetRef =
          await _firestore.collection(Paths.subsets).add(subSet.toMap());

      final setRef = _firestore.collection(Paths.sets).doc(setModel.name);
      final setSnap = await setRef.get();
      if (setSnap.exists) {
        // update the set
        setRef.update({
          'subsets': FieldValue.arrayUnion([subSetRef.id])
        });
      } else {
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

  Future<List<SubSet?>> getSubSets() async {
    try {
      final subSetsSnaps = await _firestore.collection(Paths.subsets).get();

      List<SubSet?> subSets = [];

      for (var item in subSetsSnaps.docs) {
        subSets.add(await SubSet.fromDocument(item));
      }

      return subSets;
    } catch (error) {
      print('Error getting sets ${error.toString()}');
      throw const Failure(message: 'Error getting sets');
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