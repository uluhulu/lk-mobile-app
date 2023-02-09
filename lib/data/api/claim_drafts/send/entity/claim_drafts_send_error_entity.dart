import 'package:json_annotation/json_annotation.dart';

part 'claim_drafts_send_error_entity.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimsDraftSendError {
  final String message;
  //@JsonKey(fromJson: _errorsFromJson)
  final Map<String, ClaimDraftsErrorsData> errors;

  ClaimsDraftSendError({
    required this.message,
    required this.errors,
  });

  factory ClaimsDraftSendError.fromJson(Map<String, dynamic> json) =>
      _$ClaimsDraftSendErrorFromJson(json);

  // static _errorsFromJson(dynamic json) {
  //   if (json is List) {
  //     return json.asMap().map((key, value) {
  //       return MapEntry(key.toString(), ClaimDraftsErrorsData.fromJson(value));
  //     });
  //   } else if (json is Map) {
  //     return json.map((key, value) {
  //       return MapEntry(key, ClaimDraftsErrorsData.fromJson(value));
  //     });
  //   } else {
  //     return {};
  //   }
  // }
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimDraftsErrorsData {
  final String title;
  final List<ClaimDraftProductError> errors;

  ClaimDraftsErrorsData({
    required this.title,
    required this.errors,
  });

  factory ClaimDraftsErrorsData.fromJson(Map<String, dynamic> json) =>
      _$ClaimDraftsErrorsDataFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimDraftProductError {
  final String message;
  final String field;

  ClaimDraftProductError({
    required this.message,
    required this.field,
  });

  factory ClaimDraftProductError.fromJson(Map<String, dynamic> json) =>
      _$ClaimDraftProductErrorFromJson(json);
}
