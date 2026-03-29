import 'package:flutter/foundation.dart';

class ApiConstants {
  /// Must include scheme (`http://` or `https://`). Plain `localhost:3000` breaks Dio / web XHR.
  // static String get baseUrl {
  //   if (kDebugMode) {
  //     return 'http://localhost:3000';
  //   }
  //   return 'https://smart-jothidam-backend.onrender.com';
  // }

  static const String baseUrl = 'https://smart-jothidam-backend.onrender.com';

  // Auth endpoints
  static const String registerEndpoint = '/auth/register';
  static const String loginEndpoint = '/auth/login';
  static const String verifyEndpoint = '/auth/verify';
  static const String forgotPasswordEndpoint = '/auth/forgot-password';
  static const String resetPasswordEndpoint = '/auth/reset-password';
  static const String profileEndpoint = '/profile';

  // Request timeout (Render free tier cold start can exceed 30s)
  static const Duration connectionTimeout = Duration(seconds: 90);
  static const Duration receiveTimeout = Duration(seconds: 90);
}
