import 'package:advocates/models/sub_set.dart';

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

  Future<List<SetModel?>> getSets() async {
    try {
      final setsSnaps = await _firestore.collection(Paths.sets).get();
      return setsSnaps.docs
          .map((setSnap) => SetModel.fromMap(setSnap.data()))
          .toList();
    } catch (error) {
      print('Error getting sets ${error.toString()}');
      throw const Failure(message: 'Error getting sets');
    }
  }
}
