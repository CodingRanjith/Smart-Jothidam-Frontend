class ApiConstants {
  // Base URL
  static const String baseUrl = 'https://smart-jothidam-backend.onrender.com';
  
  // Auth endpoints
  static const String registerEndpoint = '/auth/register';
  static const String loginEndpoint = '/auth/login';
  static const String verifyEndpoint = '/auth/verify';
  static const String forgotPasswordEndpoint = '/auth/forgot-password';
  static const String resetPasswordEndpoint = '/auth/reset-password';
  static const String profileEndpoint = '/profile';
  
  // Request timeout
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
