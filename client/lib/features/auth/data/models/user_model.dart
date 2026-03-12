import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.firebaseUid,
    required super.email,
    required super.name,
    super.dob,
    super.birthTime,
    super.birthPlace,
    super.phone,
    super.emailVerified,
    super.createdAt,
    super.updatedAt,
  });

  // From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firebaseUid: json['firebaseUid'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
      birthTime: json['birthTime'],
      birthPlace: json['birthPlace'],
      phone: json['phone'],
      emailVerified: json['emailVerified'] ?? false,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'firebaseUid': firebaseUid,
      'email': email,
      'name': name,
      'dob': dob?.toIso8601String(),
      'birthTime': birthTime,
      'birthPlace': birthPlace,
      'phone': phone,
      'emailVerified': emailVerified,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  // Copy with
  UserModel copyWith({
    String? firebaseUid,
    String? email,
    String? name,
    DateTime? dob,
    String? birthTime,
    String? birthPlace,
    String? phone,
    bool? emailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      firebaseUid: firebaseUid ?? this.firebaseUid,
      email: email ?? this.email,
      name: name ?? this.name,
      dob: dob ?? this.dob,
      birthTime: birthTime ?? this.birthTime,
      birthPlace: birthPlace ?? this.birthPlace,
      phone: phone ?? this.phone,
      emailVerified: emailVerified ?? this.emailVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
