import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> registerUser({
    required String email,
    required String password,
    required String name,
    DateTime? dob,
    String? birthTime,
    String? birthPlace,
    String? phone,
  });

  Future<UserEntity> loginUser(String email, String password);

  Future<void> sendEmailVerification();

  Future<void> sendPasswordResetEmail(String email);

  Future<void> logout();

  Future<UserEntity> getProfile();

  Future<UserEntity> updateProfile({
    String? name,
    DateTime? dob,
    String? birthTime,
    String? birthPlace,
    String? phone,
  });

  Future<void> reloadUser();

  bool isEmailVerified();
}
