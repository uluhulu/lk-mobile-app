// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_drafts_save_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimDraftsSaveEntity _$ClaimDraftsSaveEntityFromJson(
        Map<String, dynamic> json) =>
    ClaimDraftsSaveEntity(
      comment: json['comment'] as String?,
      products: (json['products'] as List<dynamic>)
          .map((e) =>
              ClaimDraftsSaveProducts.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ClaimDraftsSaveProducts _$ClaimDraftsSaveProductsFromJson(
        Map<String, dynamic> json) =>
    ClaimDraftsSaveProducts(
      id: json['id'] as int,
      claimType: json['claim_type'] as int,
      claimQuantity: json['claim_quantity'] as int,
      claimComment: json['claim_comment'] as String,
    );
