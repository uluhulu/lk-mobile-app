// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'claim_drafts_find_overage_params.g.dart';

@JsonSerializable(
    createFactory: false, fieldRename: FieldRename.snake, includeIfNull: false)
class ClaimDraftsFindOveragesParams {
  final int page;
  final int perPage;
  final String searchQuery;
  final String? manufacturer;

  ClaimDraftsFindOveragesParams({
    this.page = 1,
    this.perPage = 25,
    required this.searchQuery,
    this.manufacturer,
  });

  Map<String, dynamic> toJson() => _$ClaimDraftsFindOveragesParamsToJson(this);

  ClaimDraftsFindOveragesParams copyWith({
    int? page,
    int? perPage,
    String? searchQuery,
  }) {
    return ClaimDraftsFindOveragesParams(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
