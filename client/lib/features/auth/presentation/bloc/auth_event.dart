import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthRegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final DateTime? dob;
  final String? birthTime;
  final String? birthPlace;
  final String? phone;

  const AuthRegisterRequested({
    required this.email,
    required this.password,
    required this.name,
    this.dob,
    this.birthTime,
    this.birthPlace,
    this.phone,
  });

  @override
  List<Object?> get props => [email, password, name, dob, birthTime, birthPlace, phone];
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class AuthLogoutRequested extends AuthEvent {}

class AuthVerifyEmailRequested extends AuthEvent {}

class AuthResendVerificationRequested extends AuthEvent {}

class AuthForgotPasswordRequested extends AuthEvent {
  final String email;

  const AuthForgotPasswordRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

class AuthGetProfileRequested extends AuthEvent {}

class AuthUpdateProfileRequested extends AuthEvent {
  final String? name;
  final DateTime? dob;
  final String? birthTime;
  final String? birthPlace;
  final String? phone;

  const AuthUpdateProfileRequested({
    this.name,
    this.dob,
    this.birthTime,
    this.birthPlace,
    this.phone,
  });

  @override
  List<Object?> get props => [name, dob, birthTime, birthPlace, phone];
}
