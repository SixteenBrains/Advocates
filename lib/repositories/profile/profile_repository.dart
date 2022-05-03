import 'package:enum_to_string/enum_to_string.dart';
import 'package:file_picker/file_picker.dart';

import '/models/app_user.dart';

import '/config/paths.dart';
import '/models/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'base_profile.repo.dart';

class ProfileRepository extends BaseProfileRepository {
  final FirebaseFirestore _firestore;

  ProfileRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> updateAccount(AppUser? user) async {
    try {
      if (user == null) {
        return;
      }

      await _firestore
          .collection(Paths.users)
          .doc(user.uid)
          .update(user.toMap());
    } catch (error) {
      print('Error in updating account ${error.toString()}');
      throw const Failure(message: 'Error in updating account');
    }
  }

  Future<AppUser?> getUserData(String? userId) async {
    try {
      if (userId == null) {
        return null;
      }
      final userSnap =
          await _firestore.collection(Paths.users).doc(userId).get();
      return AppUser.fromDocument(userSnap);
    } catch (error) {
      print('Error in getting user data ${error.toString()}');
      throw const Failure(message: 'Error in getting user data');
    }
  }

  Future<void> addMediaFormat({
    required String? userId,
    required FileType format,
  }) async {
    try {
      if (userId == null) {
        return;
      }
      await _firestore
          .collection(Paths.users)
          .doc(userId)
          .update({'format': EnumToString.convertToString(format)});
    } catch (error) {
      print('Error in updating format ${error.toString()}');
    }
  }
}
