import 'package:json_annotation/json_annotation.dart';
import 'package:mkk/data/api/dictionary/filials/entity/dictionary_filials_entity.dart';

import '../../list/entity/claim_dratfs_list_entity.dart';

part 'claim_drafts_products_entity.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimDraftsProductsEntity {
  final List<ClaimDraftsProductsData> data;
  final Meta meta;

  ClaimDraftsProductsEntity({
    required this.data,
    required this.meta,
  });

  factory ClaimDraftsProductsEntity.fromJson(Map<String, dynamic> json) =>
      _$ClaimDraftsProductsEntityFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimDraftsProductsData {
  final int id;
  final String productName;
  final String seriesName;
  final int invoiceQuantity;
  final int claimQuantity;
  final int? claimType;
  final Map<String, String>? possibleClaimTypes;
  final String? claimComment;
  final bool? isOverage;
  final bool? isMarking;
  final bool? isSelected;
  final List<ClaimDraftsListAttachments>? attachments;

  ClaimDraftsProductsData({
    required this.id,
    required this.productName,
    required this.seriesName,
    required this.invoiceQuantity,
    required this.claimQuantity,
    this.claimType,
    this.possibleClaimTypes,
    this.claimComment,
    this.isOverage,
    this.isMarking,
    this.isSelected,
    this.attachments,
  });

  factory ClaimDraftsProductsData.fromJson(Map<String, dynamic> json) =>
      _$ClaimDraftsProductsDataFromJson(json);
}
