import 'package:json_annotation/json_annotation.dart';

part 'claim_drafts_delete_products_params.g.dart';

@JsonSerializable(createFactory: false)
class ClaimDraftsDeleteProductsParams {
  final List<int> ids;

  ClaimDraftsDeleteProductsParams({
    required this.ids,
  });

  Map<String, dynamic> toJson() =>
      _$ClaimDraftsDeleteProductsParamsToJson(this);
}
