import 'package:json_annotation/json_annotation.dart';

part 'reset_password_with_code_params.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class ResetPasswordWithCodeParams {
  final String username;
  final String newPassword;
  final String code;

  ResetPasswordWithCodeParams({
    required this.username,
    required this.newPassword,
    required this.code,
  });

  Map<String, dynamic> toJson() => _$ResetPasswordWithCodeParamsToJson(this);
}
