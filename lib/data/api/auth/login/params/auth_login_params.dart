import 'package:json_annotation/json_annotation.dart';

part 'auth_login_params.g.dart';

@JsonSerializable(createFactory: false)
class AuthLoginParams {
  final String username;
  final String password;
  final int filial;

  AuthLoginParams({
    required this.username,
    required this.password,
    required this.filial,
  });

  Map<String, dynamic> toJson() => _$AuthLoginParamsToJson(this);
}
