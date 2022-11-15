import 'package:json_annotation/json_annotation.dart';

part 'auth_reset_password_params.g.dart';

@JsonSerializable(createFactory: false)
class AuthResetPasswordParams {
  final String new_password;
  final String token;

  AuthResetPasswordParams({
    required this.new_password,
    required this.token,
  });

  Map<String, dynamic> toJson() => _$AuthResetPasswordParamsToJson(this);
}
