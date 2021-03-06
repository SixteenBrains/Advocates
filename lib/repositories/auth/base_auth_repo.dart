import 'package:advocates/models/app_user.dart';

abstract class BaseAuthRepository {
  Future<AppUser?> get currentUser;
  Stream<AppUser?> get onAuthChanges;
  Future<void>? forgotPassword(String email);
  Future<AppUser?> signInWithGoogle();
  Future<AppUser?> signUpWithEmailAndPassword({
    required String? email,
    required String? password,
  });
  Future<AppUser?> loginInWithEmailAndPassword({
    required String? email,
    required String? password,
  });
  Future<void> signOut();
}
