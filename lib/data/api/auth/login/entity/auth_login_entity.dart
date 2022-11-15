import 'package:json_annotation/json_annotation.dart';

part 'auth_login_entity.g.dart';

@JsonSerializable(createToJson: false)
class AuthLoginEntity {
  final AuthData data;

  AuthLoginEntity({
    required this.data,
  });

  factory AuthLoginEntity.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginEntityFromJson(json);
}

@JsonSerializable(createToJson: false)
class AuthData {
  @JsonKey(name: 'is_login')
  final bool isLogin;
  @JsonKey(name: 'session_id')
  final String sessionId;

  AuthData({
    required this.isLogin,
    required this.sessionId,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) =>
      _$AuthDataFromJson(json);
}
