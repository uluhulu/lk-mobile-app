// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_drafts_send_error_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimsDraftSendError _$ClaimsDraftSendErrorFromJson(
        Map<String, dynamic> json) =>
    ClaimsDraftSendError(
      message: json['message'] as String,
      errors: (json['errors'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, ClaimDraftsErrorsData.fromJson(e as Map<String, dynamic>)),
      ),
    );

ClaimDraftsErrorsData _$ClaimDraftsErrorsDataFromJson(
        Map<String, dynamic> json) =>
    ClaimDraftsErrorsData(
      title: json['title'] as String,
      errors: (json['errors'] as List<dynamic>)
          .map(
              (e) => ClaimDraftProductError.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ClaimDraftProductError _$ClaimDraftProductErrorFromJson(
        Map<String, dynamic> json) =>
    ClaimDraftProductError(
      message: json['message'] as String,
      field: json['field'] as String,
    );
