// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claims_detail_products_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimsDetailProductsEntity _$ClaimsDetailProductsEntityFromJson(
        Map<String, dynamic> json) =>
    ClaimsDetailProductsEntity(
      data: (json['data'] as List<dynamic>)
          .map((e) => ClaimsProductsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ClaimsProductsData _$ClaimsProductsDataFromJson(Map<String, dynamic> json) =>
    ClaimsProductsData(
      uuid: json['uuid'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      seriesName: json['series_name'] as String?,
      claimTypeName: json['claim_type_name'] as String?,
      comment: json['comment'] as String?,
      conclusion: json['conclusion'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      summary: (json['summary'] as num?)?.toDouble(),
      quantity: json['quantity'] as int?,
      claimQuantity: json['claim_quantity'] as int?,
      attachment: (json['attachment'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Attachment _$AttachmentFromJson(Map<String, dynamic> json) => Attachment(
      name: json['name'] as String?,
      path: json['path'] as String?,
      url: json['url'] as String?,
    );
