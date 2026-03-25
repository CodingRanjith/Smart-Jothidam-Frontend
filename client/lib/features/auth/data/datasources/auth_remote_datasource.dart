import '../../../../core/network/api_service.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> registerUser(Map<String, dynamic> userData);
  Future<LoginResult> loginUser({
    required String phone,
    required String password,
  });
  Future<void> forgotPassword(String phone);
  Future<UserModel> verifyToken(String token);
  Future<UserModel> getProfile(String token);
  Future<UserModel> updateProfile(
    String token,
    Map<String, dynamic> userData,
  );
}

class LoginResult {
  final String token;
  final UserModel user;

  const LoginResult({
    required this.token,
    required this.user,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService _apiService;

  AuthRemoteDataSourceImpl(this._apiService);

  @override
  Future<UserModel> registerUser(Map<String, dynamic> userData) async {
    try {
      final response = await _apiService.post(
        ApiConstants.registerEndpoint,
        data: userData,
      );

      final body = response.data as Map<String, dynamic>;
      if (body['success'] != true) {
        throw Exception(body['message'] ?? 'Registration failed');
      }

      return UserModel.fromJson(body['data'] as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Registration failed. Please try again.');
    }
  }

  @override
  Future<LoginResult> loginUser({
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _apiService.post(
        ApiConstants.loginEndpoint,
        data: {
          'phone': phone,
          'password': password,
        },
      );

      final body = response.data as Map<String, dynamic>;
      if (body['success'] != true) {
        throw Exception(body['message'] ?? 'Login failed');
      }

      final data = body['data'] as Map<String, dynamic>;
      return LoginResult(
        token: data['token'] as String,
        user: UserModel.fromJson(data['user'] as Map<String, dynamic>),
      );
    } catch (_) {
      throw Exception('Login failed. Please check your details and try again.');
    }
  }

  @override
  Future<void> forgotPassword(String phone) async {
    try {
      final response = await _apiService.post(
        ApiConstants.forgotPasswordEndpoint,
        data: {
          'phone': phone,
        },
      );

      final body = response.data as Map<String, dynamic>;
      if (body['success'] != true) {
        throw Exception(body['message'] ?? 'Reset request failed');
      }
    } catch (_) {
      // UI relies on a generic "sent" state, so keep this tolerant.
      throw Exception('Unable to request password reset. Please try again.');
    }
  }

  @override
  Future<UserModel> verifyToken(String token) async {
    try {
      final response = await _apiService.get(
        ApiConstants.verifyEndpoint,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final body = response.data as Map<String, dynamic>;
      if (body['success'] != true) {
        throw Exception(body['message'] ?? 'Token verification failed');
      }

      return UserModel.fromJson(body['data'] as Map<String, dynamic>);
    } catch (_) {
      throw Exception('Token verification failed. Please login again.');
    }
  }

  @override
  Future<UserModel> getProfile(String token) async {
    try {
      final response = await _apiService.get(
        ApiConstants.profileEndpoint,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final body = response.data as Map<String, dynamic>;
      if (body['success'] != true) {
        throw Exception(body['message'] ?? 'Unable to load profile');
      }

      return UserModel.fromJson(body['data'] as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Unable to load your profile. Please try again.');
    }
  }

  @override
  Future<UserModel> updateProfile(String token, Map<String, dynamic> userData) async {
    try {
      final response = await _apiService.put(
        ApiConstants.profileEndpoint,
        data: userData,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final body = response.data as Map<String, dynamic>;
      if (body['success'] != true) {
        throw Exception(body['message'] ?? 'Updating profile failed');
      }

      return UserModel.fromJson(body['data'] as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Updating profile failed. Please try again.');
    }
  }
}
