import 'package:json_annotation/json_annotation.dart';

part 'claim_drafts_add_products_entity.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimDraftsAddProductsEntity {
  final List<ClaimDraftsAddProductsData> products;

  ClaimDraftsAddProductsEntity({
    required this.products,
  });

  factory ClaimDraftsAddProductsEntity.fromJson(Map<String, dynamic> json) =>
      _$ClaimDraftsAddProductsEntityFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimDraftsAddProductsData {
  final int id;
  final int claimType;
  final int claimQuantity;
  final String claimComment;

  ClaimDraftsAddProductsData({
    required this.id,
    required this.claimType,
    required this.claimQuantity,
    required this.claimComment,
  });

  factory ClaimDraftsAddProductsData.fromJson(Map<String, dynamic> json) =>
      _$ClaimDraftsAddProductsDataFromJson(json);
}
