// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_drafts_send_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimDraftsSendEntity _$ClaimDraftsSendEntityFromJson(
        Map<String, dynamic> json) =>
    ClaimDraftsSendEntity(
      claims: (json['claims'] as List<dynamic>)
          .map((e) => ClaimsSendData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ClaimsSendData _$ClaimsSendDataFromJson(Map<String, dynamic> json) =>
    ClaimsSendData(
      number: json['number'] as String,
      guid: json['guid'] as String,
      date: json['date'] as String,
    );
