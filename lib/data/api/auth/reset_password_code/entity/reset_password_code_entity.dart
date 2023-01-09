import 'package:json_annotation/json_annotation.dart';

part 'reset_password_code_entity.g.dart';

@JsonSerializable(createToJson: false)
class ResetPasswordCodeEntity {
  final ResetPasswordCodeData data;

  ResetPasswordCodeEntity({required this.data});

  factory ResetPasswordCodeEntity.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordCodeEntityFromJson(json);
}

@JsonSerializable(createToJson: false)
class ResetPasswordCodeData {
  final String message;

  ResetPasswordCodeData({required this.message});

  factory ResetPasswordCodeData.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordCodeDataFromJson(json);
}
