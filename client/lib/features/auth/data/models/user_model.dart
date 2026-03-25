import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.userId,
    super.email,
    required super.name,
    super.dob,
    super.birthTime,
    super.birthPlace,
    super.phone,
    super.mobileVerified,
    super.createdAt,
    super.updatedAt,
  });

  // From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['id']?.toString() ?? '',
      email: json['email'],
      name: json['name'] ?? '',
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
      birthTime: json['birthTime'],
      birthPlace: json['birthPlace'],
      phone: json['phone'],
      mobileVerified: json['mobileVerified'] ?? false,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'email': email,
      'name': name,
      'dob': dob?.toIso8601String(),
      'birthTime': birthTime,
      'birthPlace': birthPlace,
      'phone': phone,
      'mobileVerified': mobileVerified,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  // Copy with
  UserModel copyWith({
    String? userId,
    String? email,
    String? name,
    DateTime? dob,
    String? birthTime,
    String? birthPlace,
    String? phone,
    bool? mobileVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
      dob: dob ?? this.dob,
      birthTime: birthTime ?? this.birthTime,
      birthPlace: birthPlace ?? this.birthPlace,
      phone: phone ?? this.phone,
      mobileVerified: mobileVerified ?? this.mobileVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
