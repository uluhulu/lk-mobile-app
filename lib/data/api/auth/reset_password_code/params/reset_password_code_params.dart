import 'package:json_annotation/json_annotation.dart';

part 'reset_password_code_params.g.dart';

@JsonSerializable(createFactory: false)
class ResetPasswordCodeParams {
  final String username;
  final String code;
  ResetPasswordCodeParams({
    required this.username,
    required this.code,
  });

  Map<String, dynamic> toJson() => _$ResetPasswordCodeParamsToJson(this);
}
