// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_drafts_add_products_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimDraftsAddProductsEntity _$ClaimDraftsAddProductsEntityFromJson(
        Map<String, dynamic> json) =>
    ClaimDraftsAddProductsEntity(
      products: (json['products'] as List<dynamic>)
          .map((e) =>
              ClaimDraftsAddProductsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ClaimDraftsAddProductsData _$ClaimDraftsAddProductsDataFromJson(
        Map<String, dynamic> json) =>
    ClaimDraftsAddProductsData(
      id: json['id'] as int,
      claimType: json['claim_type'] as int,
      claimQuantity: json['claim_quantity'] as int,
      claimComment: json['claim_comment'] as String,
    );
