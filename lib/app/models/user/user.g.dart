// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as int?,
      token: json['token'] == null
          ? null
          : Token.fromJson(json['token'] as Map<String, dynamic>),
      email: json['email'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      username: json['username'] as String?,
      isActive: json['is_active'] as bool?,
      isSuperuser: json['is_superuser'] as bool?,
      mobile: json['mobile'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      about: json['about'] as String?,
      isVerified: json['is_verified'] as bool?,
      image: json['image'] as String?,
      year: json['year'] as int?,
      branch: json['branch'] as String?,
      linkedin: json['linkedin'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'email': instance.email,
      'name': instance.name,
      'type': instance.type,
      'username': instance.username,
      'is_active': instance.isActive,
      'is_superuser': instance.isSuperuser,
      'mobile': instance.mobile,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'about': instance.about,
      'is_verified': instance.isVerified,
      'image': instance.image,
      'year': instance.year,
      'branch': instance.branch,
      'linkedin': instance.linkedin,
    };
