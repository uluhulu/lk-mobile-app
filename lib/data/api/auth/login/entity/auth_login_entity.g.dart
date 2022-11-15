// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthLoginEntity _$AuthLoginEntityFromJson(Map<String, dynamic> json) =>
    AuthLoginEntity(
      data: AuthData.fromJson(json['data'] as Map<String, dynamic>),
    );

AuthData _$AuthDataFromJson(Map<String, dynamic> json) => AuthData(
      isLogin: json['is_login'] as bool,
      sessionId: json['session_id'] as String,
    );
