import 'package:json_annotation/json_annotation.dart';

part 'claim_drafts_save_entity.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimDraftsSaveEntity {
  final String? comment;
  final List<ClaimDraftsSaveProducts> products;

  ClaimDraftsSaveEntity({
    this.comment,
    required this.products,
  });

  factory ClaimDraftsSaveEntity.fromJson(Map<String, dynamic> json) =>
      _$ClaimDraftsSaveEntityFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimDraftsSaveProducts {
  final int id;
  final int claimType;
  final int claimQuantity;
  final String claimComment;

  ClaimDraftsSaveProducts({
    required this.id,
    required this.claimType,
    required this.claimQuantity,
    required this.claimComment,
  });

  factory ClaimDraftsSaveProducts.fromJson(Map<String, dynamic> json) =>
      _$ClaimDraftsSaveProductsFromJson(json);
}
