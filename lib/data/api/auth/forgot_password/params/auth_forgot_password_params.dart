import 'package:json_annotation/json_annotation.dart';

part 'auth_forgot_password_params.g.dart';

@JsonSerializable(createFactory: false)
class AuthForgotPasswordParams {
  final String username;
  final int filial;

  AuthForgotPasswordParams({
    required this.username,
    required this.filial,
  });

  Map<String, dynamic> toJson() => _$AuthForgotPasswordParamsToJson(this);
}
