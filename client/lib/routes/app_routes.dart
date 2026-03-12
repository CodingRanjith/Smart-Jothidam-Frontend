import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';
import '../features/auth/presentation/pages/splash_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/register_page.dart';
import '../features/auth/presentation/pages/verify_email_page.dart';
import '../features/auth/presentation/pages/forgot_password_page.dart';
import '../features/auth/presentation/pages/profile_page.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      
      case AppConstants.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      
      case AppConstants.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      
      case AppConstants.verifyEmailRoute:
        return MaterialPageRoute(builder: (_) => const VerifyEmailPage());
      
      case AppConstants.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      
      case AppConstants.profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      
      case AppConstants.homeRoute:
        // TODO: Create home page
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Home Page - Coming Soon')),
          ),
        );
      
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
