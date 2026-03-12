import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository _repository;

  RegisterUser(this._repository);

  Future<UserEntity> call({
    required String email,
    required String password,
    required String name,
    DateTime? dob,
    String? birthTime,
    String? birthPlace,
    String? phone,
  }) async {
    return await _repository.registerUser(
      email: email,
      password: password,
      name: name,
      dob: dob,
      birthTime: birthTime,
      birthPlace: birthPlace,
      phone: phone,
    );
  }
}
