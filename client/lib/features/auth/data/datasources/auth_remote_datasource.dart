import '../../../../core/network/api_service.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> registerUser(String token, Map<String, dynamic> userData);
  Future<UserModel> verifyToken(String token);
  Future<UserModel> getProfile(String token);
  Future<UserModel> updateProfile(String token, Map<String, dynamic> userData);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService _apiService;

  AuthRemoteDataSourceImpl(this._apiService);

  @override
  Future<UserModel> registerUser(String token, Map<String, dynamic> userData) async {
    try {
      final response = await _apiService.post(
        ApiConstants.registerEndpoint,
        data: userData,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Registration failed. Please try again.');
    }
  }

  @override
  Future<UserModel> verifyToken(String token) async {
    try {
      final response = await _apiService.post(
        ApiConstants.verifyEndpoint,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Login failed. Please check your details and try again.');
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
      return UserModel.fromJson(response.data);
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
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Updating profile failed. Please try again.');
    }
  }
}
