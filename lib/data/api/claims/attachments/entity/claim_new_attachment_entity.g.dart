// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_new_attachment_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimsNewAttachmentsEntity _$ClaimsNewAttachmentsEntityFromJson(
        Map<String, dynamic> json) =>
    ClaimsNewAttachmentsEntity(
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => AttachmentsEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: (json['errors'] as List<dynamic>)
          .map((e) => Errors.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ImageData _$ImageDataFromJson(Map<String, dynamic> json) => ImageData(
      data: AttachmentsEntity.fromJson(json['data'] as Map<String, dynamic>),
    );

AttachmentsEntity _$AttachmentsEntityFromJson(Map<String, dynamic> json) =>
    AttachmentsEntity(
      name: json['name'] as String?,
      path: json['path'] as String?,
      base64: json['base64'] as String?,
    );

Errors _$ErrorsFromJson(Map<String, dynamic> json) => Errors(
      name: json['name'] as String?,
      message: json['message'] as String?,
    );
