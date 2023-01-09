// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_drafts_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimDraftsInfoEntity _$ClaimDraftsInfoEntityFromJson(
        Map<String, dynamic> json) =>
    ClaimDraftsInfoEntity(
      data: ClaimDraftsInfoData.fromJson(json['data'] as Map<String, dynamic>),
    );

ClaimDraftsInfoData _$ClaimDraftsInfoDataFromJson(Map<String, dynamic> json) =>
    ClaimDraftsInfoData(
      id: json['id'] as int,
      claimDate: json['claim_date'] as String,
      invoice: json['invoice'] as String,
      invoiceGuid: json['invoice_guid'] as String,
      cargoName: json['cargo_name'] as String,
      cargoAddress: json['cargo_address'] as String,
      comment: json['comment'] as String?,
      countProductsByClaim: json['count_products_by_claim'] as int?,
      countProductsByInvoice: json['count_products_by_invoice'] as int?,
      canSend: json['can_send'] as bool?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) =>
              ClaimDraftsListAttachments.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
