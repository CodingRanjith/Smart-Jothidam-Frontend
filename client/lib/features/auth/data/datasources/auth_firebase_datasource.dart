import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/services/firebase_auth_service.dart';

abstract class AuthFirebaseDataSource {
  Future<User> registerWithEmailAndPassword(String email, String password);
  Future<User> loginWithEmailAndPassword(String email, String password);
  Future<void> sendEmailVerification();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> logout();
  Future<String?> getIdToken();
  Future<void> reloadUser();
  User? getCurrentUser();
  bool isEmailVerified();
}

class AuthFirebaseDataSourceImpl implements AuthFirebaseDataSource {
  final FirebaseAuthService _firebaseAuthService;

  AuthFirebaseDataSourceImpl(this._firebaseAuthService);

  @override
  Future<User> registerWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _firebaseAuthService.registerWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> loginWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _firebaseAuthService.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      await _firebaseAuthService.sendEmailVerification();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuthService.sendPasswordResetEmail(email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuthService.logout();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> getIdToken() async {
    try {
      return await _firebaseAuthService.getIdToken();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> reloadUser() async {
    try {
      await _firebaseAuthService.reloadUser();
    } catch (e) {
      rethrow;
    }
  }

  @override
  User? getCurrentUser() {
    return _firebaseAuthService.currentUser;
  }

  @override
  bool isEmailVerified() {
    return _firebaseAuthService.isEmailVerified;
  }
}
