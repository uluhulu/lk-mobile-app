import 'package:json_annotation/json_annotation.dart';

import '../../list/entity/claim_dratfs_list_entity.dart';

part 'claim_drafts_info_entity.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimDraftsInfoEntity {
  final ClaimDraftsInfoData data;

  ClaimDraftsInfoEntity({
    required this.data,
  });

  factory ClaimDraftsInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$ClaimDraftsInfoEntityFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimDraftsInfoData {
  final int id;
  final String claimDate;
  final String invoice;
  final String invoiceGuid;
  final String cargoName;
  final String cargoAddress;
  final String? comment;
  final int? countProductsByClaim;
  final int? countProductsByInvoice;
  final bool? canSend;
  final List<ClaimDraftsListAttachments>? attachments;

  ClaimDraftsInfoData({
    required this.id,
    required this.claimDate,
    required this.invoice,
    required this.invoiceGuid,
    required this.cargoName,
    required this.cargoAddress,
    this.comment,
    this.countProductsByClaim,
    this.countProductsByInvoice,
    this.canSend,
    this.attachments,
  });

  factory ClaimDraftsInfoData.fromJson(Map<String, dynamic> json) =>
      _$ClaimDraftsInfoDataFromJson(json);
}
