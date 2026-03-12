import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_firebase_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebaseDataSource _firebaseDataSource;
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._firebaseDataSource, this._remoteDataSource);

  @override
  Future<UserEntity> registerUser({
    required String email,
    required String password,
    required String name,
    DateTime? dob,
    String? birthTime,
    String? birthPlace,
    String? phone,
  }) async {
    try {
      // Register with Firebase
      await _firebaseDataSource.registerWithEmailAndPassword(
        email,
        password,
      );

      // Send email verification
      await _firebaseDataSource.sendEmailVerification();

      // Get Firebase ID token
      final token = await _firebaseDataSource.getIdToken();

      // Register with backend
      final userData = {
        'name': name,
        'email': email,
        if (dob != null) 'dob': dob.toIso8601String(),
        if (birthTime != null) 'birthTime': birthTime,
        if (birthPlace != null) 'birthPlace': birthPlace,
        if (phone != null) 'phone': phone,
      };

      final user = await _remoteDataSource.registerUser(token!, userData);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> loginUser(String email, String password) async {
    try {
      // Login with Firebase
      await _firebaseDataSource.loginWithEmailAndPassword(email, password);

      // Get Firebase ID token
      final token = await _firebaseDataSource.getIdToken();

      // Verify token with backend and get profile
      final user = await _remoteDataSource.verifyToken(token!);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      await _firebaseDataSource.sendEmailVerification();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseDataSource.sendPasswordResetEmail(email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseDataSource.logout();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> getProfile() async {
    try {
      final token = await _firebaseDataSource.getIdToken();
      final user = await _remoteDataSource.getProfile(token!);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> updateProfile({
    String? name,
    DateTime? dob,
    String? birthTime,
    String? birthPlace,
    String? phone,
  }) async {
    try {
      final token = await _firebaseDataSource.getIdToken();
      final userData = {
        if (name != null) 'name': name,
        if (dob != null) 'dob': dob.toIso8601String(),
        if (birthTime != null) 'birthTime': birthTime,
        if (birthPlace != null) 'birthPlace': birthPlace,
        if (phone != null) 'phone': phone,
      };
      final user = await _remoteDataSource.updateProfile(token!, userData);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> reloadUser() async {
    try {
      await _firebaseDataSource.reloadUser();
    } catch (e) {
      rethrow;
    }
  }

  @override
  bool isEmailVerified() {
    return _firebaseDataSource.isEmailVerified();
  }
}
