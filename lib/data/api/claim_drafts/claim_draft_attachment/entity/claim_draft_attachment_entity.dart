import 'package:json_annotation/json_annotation.dart';

part 'claim_draft_attachment_entity.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimDraftAttachmentEntity {
  final int id;
  final String name;

  final String url;

  final String base64;

  factory ClaimDraftAttachmentEntity.fromJson(Map<String, dynamic> json) =>
      _$ClaimDraftAttachmentEntityFromJson(json);

  ClaimDraftAttachmentEntity(this.id, this.name, this.url, this.base64);
}

