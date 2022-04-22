import '/config/paths.dart';
import '/models/failure.dart';
import '/models/set_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/repositories/set/base_set_repo.dart';

class SetRepository extends BaseSetRepo {
  final FirebaseFirestore _firestore;

  SetRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<String?> uploadSet(SetModel? set) async {
    try {
      if (set == null) {
        return null;
      }
      final docRef = await _firestore.collection(Paths.sets).add(set.toMap());
      return docRef.id;
    } catch (error) {
      print('Error in uploading set ${error.toString()}');
      throw const Failure(message: 'Error uploading set');
    }
  }
}
