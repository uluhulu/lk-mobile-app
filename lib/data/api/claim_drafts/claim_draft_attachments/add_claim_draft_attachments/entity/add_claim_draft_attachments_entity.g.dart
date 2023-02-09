// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_claim_draft_attachments_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddClaimDraftAttachmentsEntity _$AddClaimDraftAttachmentsEntityFromJson(
        Map<String, dynamic> json) =>
    AddClaimDraftAttachmentsEntity(
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) =>
              ClaimDraftsListAttachments.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => Errors.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Errors _$ErrorsFromJson(Map<String, dynamic> json) => Errors(
      name: json['name'] as String?,
      message: json['message'] as String?,
    );
