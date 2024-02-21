import 'package:freezed_annotation/freezed_annotation.dart';

import 'skill.dart';
import 'token.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    int? id,
    Token? token,
    List<Skill>? skills,
    String? email,
    String? name,
    String? type,
    String? username,
    @JsonKey(name: 'is_active') bool? isActive,
    @JsonKey(name: 'is_superuser') bool? isSuperuser,
    String? mobile,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    String? about,
    @JsonKey(name: 'is_verified') bool? isVerified,
    String? image,
    String? linkedin,
    String? github,
    String? resume,
    @JsonKey(name: 'experience_years') int? experienceYears,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

class UserTypes {
  static const String STUDENT = 'student';
  static const String FACULTY = 'faculty';
  static const String ALUMNI = 'alumni';
  static const String COMPANY = 'company';
  static const String ADMIN = 'admin';
}
