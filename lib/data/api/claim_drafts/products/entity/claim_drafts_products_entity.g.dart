// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_drafts_products_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimDraftsProductsEntity _$ClaimDraftsProductsEntityFromJson(
        Map<String, dynamic> json) =>
    ClaimDraftsProductsEntity(
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              ClaimDraftsProductsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ClaimDraftsProductsData _$ClaimDraftsProductsDataFromJson(
        Map<String, dynamic> json) =>
    ClaimDraftsProductsData(
      id: json['id'] as int,
      productName: json['product_name'] as String,
      seriesName: json['series_name'] as String,
      invoiceQuantity: json['invoice_quantity'] as int,
      claimQuantity: json['claim_quantity'] as int,
      claimType: json['claim_type'] as int?,
      possibleClaimTypes:
          (json['possible_claim_types'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      claimComment: json['claim_comment'] as String?,
      isOverage: json['is_overage'] as bool?,
      isMarking: json['is_marking'] as bool?,
      isSelected: json['is_selected'] as bool?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) =>
              ClaimDraftsListAttachments.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
