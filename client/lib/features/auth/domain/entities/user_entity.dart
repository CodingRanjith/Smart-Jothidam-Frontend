import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String firebaseUid;
  final String email;
  final String name;
  final DateTime? dob;
  final String? birthTime;
  final String? birthPlace;
  final String? phone;
  final bool emailVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserEntity({
    required this.firebaseUid,
    required this.email,
    required this.name,
    this.dob,
    this.birthTime,
    this.birthPlace,
    this.phone,
    this.emailVerified = false,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        firebaseUid,
        email,
        name,
        dob,
        birthTime,
        birthPlace,
        phone,
        emailVerified,
        createdAt,
        updatedAt,
      ];
}
