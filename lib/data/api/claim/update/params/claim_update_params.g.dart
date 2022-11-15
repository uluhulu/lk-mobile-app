// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_update_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ClaimUpdateParamsToJson(ClaimUpdateParams instance) =>
    <String, dynamic>{
      'claimdoc': instance.claimdoc,
      'claimdate': instance.claimdate,
      'claimGoods': instance.claimGoods,
    };

Map<String, dynamic> _$ClaimGoodsToJson(ClaimGoods instance) =>
    <String, dynamic>{
      'ean': instance.ean,
      'ser': instance.ser,
      'expirationDate': instance.expirationDate,
      'claimCount': instance.claimCount,
      'mark': instance.mark,
      'claimtype': instance.claimtype,
      'wish': instance.wish,
      'comment': instance.comment,
      'price': instance.price,
      'attachments': instance.attachments,
    };

Map<String, dynamic> _$AttachmentsToJson(Attachments instance) =>
    <String, dynamic>{
      'name': instance.name,
      'content': instance.content,
    };
