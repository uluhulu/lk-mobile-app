// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_find_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimFindEntity _$ClaimFindEntityFromJson(Map<String, dynamic> json) =>
    ClaimFindEntity(
      claimdocs: (json['claimdocs'] as List<dynamic>)
          .map((e) => ClaimDocs.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ClaimDocs _$ClaimDocsFromJson(Map<String, dynamic> json) => ClaimDocs(
      claimdoc: json['claimdoc'] as String,
      claimdate: json['claimdate'] as String,
      saledoc: json['saledoc'] as String,
      saledate: json['saledate'] as String,
      turnoverdoc: json['turnoverdoc'] as String,
      turnoverdate: json['turnoverdate'] as String,
      status: json['status'] as String,
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
      resolution: json['resolution'] as String,
      comment: json['comment'] as String,
      price: (json['price'] as num).toDouble(),
    );
