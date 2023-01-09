import 'package:json_annotation/json_annotation.dart';

part 'claim_drafts_products_params.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class ClaimDraftsProductsParams {
  final int id;
  @JsonKey(includeIfNull: false)
  final int? page;
  @JsonKey(includeIfNull: false)
  final int? perPage;
  @JsonKey(includeIfNull: false)
  final int? isSelected;
  @JsonKey(includeIfNull: false)
  final String? searchQuery;

  ClaimDraftsProductsParams({
    required this.id,
    this.page,
    this.perPage,
    this.isSelected,
    this.searchQuery,
  });

  Map<String, dynamic> toJson() => _$ClaimDraftsProductsParamsToJson(this);
}
