// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_dratfs_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimDraftsListEntity _$ClaimDraftsListEntityFromJson(
        Map<String, dynamic> json) =>
    ClaimDraftsListEntity(
      data: (json['data'] as List<dynamic>)
          .map((e) => ClaimDraftsListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: json['links'] == null
          ? null
          : Links.fromJson(json['links'] as Map<String, dynamic>),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

ClaimDraftsListData _$ClaimDraftsListDataFromJson(Map<String, dynamic> json) =>
    ClaimDraftsListData(
      id: json['id'] as int,
      claimDate: json['claim_date'] as String,
      invoice: json['invoice'] as String?,
      invoiceDate: json['invoice_date'] as String?,
      invoiceGuid: json['invoice_guid'] as String?,
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

ClaimDraftsListAttachments _$ClaimDraftsListAttachmentsFromJson(
        Map<String, dynamic> json) =>
    ClaimDraftsListAttachments(
      id: json['id'] as int?,
      name: json['name'] as String?,
      url: json['url'] as String?,
    );
