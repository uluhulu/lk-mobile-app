// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_create_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimCreateEntity _$ClaimCreateEntityFromJson(Map<String, dynamic> json) =>
    ClaimCreateEntity(
      success: json['success'] as bool,
      claims: (json['claims'] as List<dynamic>)
          .map((e) => Claims.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Claims _$ClaimsFromJson(Map<String, dynamic> json) => Claims(
      claimdoc: json['claimdoc'] as String,
      claimdate: json['claimdate'] as String,
      claimGoods: (json['claimGoods'] as List<dynamic>)
          .map((e) => ClaimGoods.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ClaimGoods _$ClaimGoodsFromJson(Map<String, dynamic> json) => ClaimGoods(
      ean: json['ean'] as String,
      ser: json['ser'] as String,
      expirationDate: json['expirationDate'] as String,
      claimCount: json['claimCount'] as int,
      mark: json['mark'] as bool,
      claimtype: json['claimtype'] as int,
      wish: json['wish'] as int,
      price: (json['price'] as num).toDouble(),
    );
