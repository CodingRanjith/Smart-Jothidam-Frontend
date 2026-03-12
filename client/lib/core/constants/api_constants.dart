class ApiConstants {
  // Base URL
  static const String baseUrl = 'http://localhost:3000';
  
  // Auth endpoints
  static const String registerEndpoint = '/auth/register';
  static const String verifyEndpoint = '/auth/verify';
  static const String profileEndpoint = '/profile';
  
  // Request timeout
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
