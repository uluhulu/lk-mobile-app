import 'package:json_annotation/json_annotation.dart';

import '../../../dictionary/filials/entity/dictionary_filials_entity.dart';

part 'claim_dratfs_list_entity.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimDraftsListEntity {
  final List<ClaimDraftsListData> data;
  final Links? links;
  final Meta meta;

  ClaimDraftsListEntity({
    required this.data,
    this.links,
    required this.meta,
  });

  factory ClaimDraftsListEntity.fromJson(Map<String, dynamic> json) =>
      _$ClaimDraftsListEntityFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimDraftsListData {
  final int id;
  final String claimDate;
  final String? invoice;
  final String? invoiceDate;
  final String? invoiceGuid;
  final String cargoName;
  final String cargoAddress;
  final String? comment;
  final int? countProductsByClaim;
  final int? countProductsByInvoice;
  final bool? canSend;
  final List<ClaimDraftsListAttachments>? attachments;

  ClaimDraftsListData({
    required this.id,
    required this.claimDate,
    this.invoice,
    this.invoiceDate,
    this.invoiceGuid,
    required this.cargoName,
    required this.cargoAddress,
    this.comment,
    this.countProductsByClaim,
    this.countProductsByInvoice,
    this.canSend,
    this.attachments,
  });

  factory ClaimDraftsListData.fromJson(Map<String, dynamic> json) =>
      _$ClaimDraftsListDataFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimDraftsListAttachments {
  final int? id;
  final String? name;
  final String? url;

  ClaimDraftsListAttachments({
    this.id,
    this.name,
    this.url,
  });

  factory ClaimDraftsListAttachments.fromJson(Map<String, dynamic> json) =>
      _$ClaimDraftsListAttachmentsFromJson(json);
}
