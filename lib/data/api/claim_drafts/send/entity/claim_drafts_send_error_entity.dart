import 'package:json_annotation/json_annotation.dart';

part 'claim_drafts_send_error_entity.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimDraftsSendErrorEntity {
  final String message;
  final List<ClaimDraftsErrorsData> errors;

  ClaimDraftsSendErrorEntity({
    required this.message,
    required this.errors,
  });

  factory ClaimDraftsSendErrorEntity.fromJson(Map<String, dynamic> json) =>
      _$ClaimDraftsSendErrorEntityFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimDraftsErrorsData {
  final int id;
  final String title;
  final List<ClaimsDraftsErrorList> errors;

  ClaimDraftsErrorsData({
    required this.id,
    required this.title,
    required this.errors,
  });

  factory ClaimDraftsErrorsData.fromJson(Map<String, dynamic> json) =>
      _$ClaimDraftsErrorsDataFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimsDraftsErrorList {
  final String field;
  final String message;

  ClaimsDraftsErrorList({
    required this.field,
    required this.message,
  });

  factory ClaimsDraftsErrorList.fromJson(Map<String, dynamic> json) =>
      _$ClaimsDraftsErrorListFromJson(json);
}
