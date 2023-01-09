import 'package:json_annotation/json_annotation.dart';

part 'claim_drafts_save_params.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class ClaimDraftsSaveParams {
  final String? comment;
  final List<ClaimDraftsProductsModel> products;

  ClaimDraftsSaveParams({
    this.comment,
    required this.products,
  });

  Map<String, dynamic> toJson() => _$ClaimDraftsSaveParamsToJson(this);
}

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class ClaimDraftsProductsModel {
  final int? id;
  final int? claimType;
  final int? claimQuantity;
  final String? claimComment;

  ClaimDraftsProductsModel({
    required this.id,
    required this.claimType,
    required this.claimQuantity,
    required this.claimComment,
  });

  Map<String, dynamic> toJson() => _$ClaimDraftsProductsModelToJson(this);
}
