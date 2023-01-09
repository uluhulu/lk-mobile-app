import 'package:json_annotation/json_annotation.dart';

part 'search_claims_params.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class SearchClaimsParams {
  final int? page;
  final int? perPage;
  final String number;

  SearchClaimsParams({
    this.page,
    this.perPage,
    required this.number,
  });

  Map<String, dynamic> toJson() => _$SearchClaimsParamsToJson(this);
}
