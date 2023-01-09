// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'claim_drafts_create_params.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class ClaimDraftsCreateParams {
  final String invoiceGuid;
  final List<String> selectedProducts;

  ClaimDraftsCreateParams({
    required this.invoiceGuid,
    required this.selectedProducts,
  });

  Map<String, dynamic> toJson() => _$ClaimDraftsCreateParamsToJson(this);
}
