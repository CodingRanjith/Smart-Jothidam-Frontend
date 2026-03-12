import '../repositories/auth_repository.dart';

class VerifyEmail {
  final AuthRepository _repository;

  VerifyEmail(this._repository);

  Future<void> call() async {
    await _repository.reloadUser();
  }
}
