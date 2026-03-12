import '../repositories/auth_repository.dart';

class ResendVerification {
  final AuthRepository _repository;

  ResendVerification(this._repository);

  Future<void> call() async {
    await _repository.sendEmailVerification();
  }
}
