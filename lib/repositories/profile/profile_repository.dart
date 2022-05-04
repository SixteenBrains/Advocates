import '/enums/enums.dart';
import 'package:enum_to_string/enum_to_string.dart';
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

  // Formare section

  Future<void> addMediaFormat({
    required String? userId,
    required MediaType mediaType,
  }) async {
    try {
      if (userId == null) {
        return;
      }
      await _firestore.collection(Paths.users).doc(userId).update(
          {'format': EnumToString.convertToString(mediaType).toUpperCase()});
    } catch (error) {
      print('Error in updating format ${error.toString()}');
    }
  }

  Future<String?> getSelectedMediaFormat({required String? userId}) async {
    try {
      if (userId == null) {
        return null;
      }
      final userSnap =
          await _firestore.collection(Paths.users).doc(userId).get();
      final user = AppUser.fromDocument(userSnap);

      return user?.format;
    } catch (error) {
      print('Error getting selected media format ${error.toString()}');
      throw (const Failure(message: 'Error in getting format'));
    }
  }

  Future<void> uploadCauses(
      {required String? userId, required List<String?> causes}) async {
    try {
      if (userId == null) {
        return;
      }
      await _firestore
          .collection(Paths.users)
          .doc(userId)
          .update({'causes': causes});
    } catch (error) {
      print('Error uploading causes ${error.toString()}');
      throw const Failure(message: 'Error in uploading causes');
    }
  }

  Future<List<String?>> getSelectedCauses({required String? userId}) async {
    try {
      final userSnap =
          await _firestore.collection(Paths.users).doc(userId).get();
      final user = AppUser.fromDocument(userSnap);

      return user?.causes ?? [];
    } catch (error) {
      print('Error in getting causes ${error.toString()}');
      throw const Failure(message: 'Error in getting causes');
    }
  }
}
