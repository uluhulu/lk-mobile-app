// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_drafts_send_error_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimDraftsSendErrorEntity _$ClaimDraftsSendErrorEntityFromJson(
        Map<String, dynamic> json) =>
    ClaimDraftsSendErrorEntity(
      message: json['message'] as String,
      errors: (json['errors'] as List<dynamic>)
          .map((e) => ClaimDraftsErrorsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ClaimDraftsErrorsData _$ClaimDraftsErrorsDataFromJson(
        Map<String, dynamic> json) =>
    ClaimDraftsErrorsData(
      id: json['id'] as int,
      title: json['title'] as String,
      errors: (json['errors'] as List<dynamic>)
          .map((e) => ClaimsDraftsErrorList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ClaimsDraftsErrorList _$ClaimsDraftsErrorListFromJson(
        Map<String, dynamic> json) =>
    ClaimsDraftsErrorList(
      field: json['field'] as String,
      message: json['message'] as String,
    );
