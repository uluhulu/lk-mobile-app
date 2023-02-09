import 'package:json_annotation/json_annotation.dart';

part 'claim_drafts_add_overages_params.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class ClaimDraftAddOveragesParams {
  final String guid;
  final String name;
  final String seriesGuid;
  final String seriesName;

  ClaimDraftAddOveragesParams({
    required this.guid,
    required this.name,
    required this.seriesGuid,
    required this.seriesName,
  });

  Map<String, dynamic> toJson() => _$ClaimDraftAddOveragesParamsToJson(this);
}
