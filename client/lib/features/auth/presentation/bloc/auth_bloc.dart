import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/register_user.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/verify_email.dart';
import '../../domain/usecases/resend_verification.dart';
import '../../domain/usecases/forgot_password.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/update_profile.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUser _registerUser;
  final LoginUser _loginUser;
  final VerifyEmail _verifyEmail;
  final ResendVerification _resendVerification;
  final ForgotPassword _forgotPassword;
  final GetProfile _getProfile;
  final UpdateProfile _updateProfile;

  AuthBloc({
    required RegisterUser registerUser,
    required LoginUser loginUser,
    required VerifyEmail verifyEmail,
    required ResendVerification resendVerification,
    required ForgotPassword forgotPassword,
    required GetProfile getProfile,
    required UpdateProfile updateProfile,
  })  : _registerUser = registerUser,
        _loginUser = loginUser,
        _verifyEmail = verifyEmail,
        _resendVerification = resendVerification,
        _forgotPassword = forgotPassword,
        _getProfile = getProfile,
        _updateProfile = updateProfile,
        super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthVerifyEmailRequested>(_onAuthVerifyEmailRequested);
    on<AuthResendVerificationRequested>(_onAuthResendVerificationRequested);
    on<AuthForgotPasswordRequested>(_onAuthForgotPasswordRequested);
    on<AuthGetProfileRequested>(_onAuthGetProfileRequested);
    on<AuthUpdateProfileRequested>(_onAuthUpdateProfileRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // Check auth state and get profile
      final user = await _getProfile();
      if (user.emailVerified) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthEmailNotVerified(user: user));
      }
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onAuthRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _registerUser(
        email: event.email,
        password: event.password,
        name: event.name,
        dob: event.dob,
        birthTime: event.birthTime,
        birthPlace: event.birthPlace,
        phone: event.phone,
      );
      emit(AuthVerificationEmailSent());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _loginUser(event.email, event.password);
      if (user.emailVerified) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthEmailNotVerified(user: user));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // Call logout from repository
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onAuthVerifyEmailRequested(
    AuthVerifyEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _verifyEmail();
      final user = await _getProfile();
      if (user.emailVerified) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthEmailNotVerified(user: user));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onAuthResendVerificationRequested(
    AuthResendVerificationRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _resendVerification();
      emit(AuthSuccess(message: 'Verification email sent'));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onAuthForgotPasswordRequested(
    AuthForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _forgotPassword(event.email);
      emit(AuthPasswordResetEmailSent());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onAuthGetProfileRequested(
    AuthGetProfileRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _getProfile();
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onAuthUpdateProfileRequested(
    AuthUpdateProfileRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _updateProfile(
        name: event.name,
        dob: event.dob,
        birthTime: event.birthTime,
        birthPlace: event.birthPlace,
        phone: event.phone,
      );
      emit(AuthAuthenticated(user: user));
      emit(AuthSuccess(message: 'Profile updated successfully'));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
