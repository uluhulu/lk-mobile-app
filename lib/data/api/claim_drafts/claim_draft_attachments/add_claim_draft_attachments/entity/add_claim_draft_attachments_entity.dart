import 'package:json_annotation/json_annotation.dart';
import 'package:mkk/data/api/claim_drafts/list/entity/claim_dratfs_list_entity.dart';

part 'add_claim_draft_attachments_entity.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class AddClaimDraftAttachmentsEntity {
  final List<ClaimDraftsListAttachments> attachments;
  List<Errors>? errors;

  AddClaimDraftAttachmentsEntity({
    required this.attachments,
    this.errors,
  });

  factory AddClaimDraftAttachmentsEntity.fromJson(Map<String, dynamic> json) =>
      _$AddClaimDraftAttachmentsEntityFromJson(json);
}

// @JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
// class ClaimDraftAttachmentsEntity {
//   final int id;
//   final String name;
//   final String url;
//
//   ClaimDraftAttachmentsEntity(
//       {required this.name, required this.url, required this.id});
//
//   factory ClaimDraftAttachmentsEntity.fromJson(Map<String, dynamic> json) =>
//       _$ClaimDraftAttachmentsEntityFromJson(json);
// }

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class Errors {
  String? name;
  String? message;

  Errors({this.name, this.message});

  factory Errors.fromJson(Map<String, dynamic> json) => _$ErrorsFromJson(json);
}
