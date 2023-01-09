// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'claim_draft_create_entity.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimDraftCreateEntity {
  final int draftId;
  ClaimDraftCreateEntity({
    required this.draftId,
  });

  factory ClaimDraftCreateEntity.fromJson(Map<String, dynamic> json) =>
      _$ClaimDraftCreateEntityFromJson(json);
}
