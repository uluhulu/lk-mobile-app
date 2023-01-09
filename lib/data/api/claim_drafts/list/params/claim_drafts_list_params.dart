// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'claim_drafts_list_params.g.dart';

enum ClaimDraftsListSorting {
  @JsonValue('claim_date DESC')
  desk,
  @JsonValue('claim_date ASC')
  asc,
}

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class ClaimDraftsListParams {
  @JsonKey(includeIfNull: false)
  final int? page;
  @JsonKey(includeIfNull: false)
  final int? perPage;
  @JsonKey(includeIfNull: false)
  final ClaimDraftsListSorting? sorting;

  ClaimDraftsListParams({
    this.page,
    this.perPage,
    this.sorting,
  });

  Map<String, dynamic> toJson() => _$ClaimDraftsListParamsToJson(this);

  ClaimDraftsListParams copyWith({
    int? page,
    int? perPage,
    ClaimDraftsListSorting? sorting,
  }) {
    return ClaimDraftsListParams(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      sorting: sorting ?? this.sorting,
    );
  }
}
