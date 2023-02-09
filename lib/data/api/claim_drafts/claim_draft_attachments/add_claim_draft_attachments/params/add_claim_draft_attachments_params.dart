import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart';

import '../../claim_draft_file.dart';

part 'add_claim_draft_attachments_params.g.dart';

@JsonSerializable( createFactory: false,fieldRename: FieldRename.snake,)
class AddClaimDraftAttachmentsParams {
  AddClaimDraftAttachmentsParams({
    required this.claimId,
    required this.productId,
    required this.attachments,
  });

   final int claimId;
   final int productId;
   final List<ClaimDraftAttachmentsParams> attachments;
  Map<String, dynamic> toJson() => _$AddClaimDraftAttachmentsParamsToJson(this);

}
@JsonSerializable( createFactory: false,fieldRename: FieldRename.snake,)
class ClaimDraftAttachmentsParams {
  ClaimDraftAttachmentsParams({
     this.name,
     this.base64,
  });

    String? name;
    String? base64;

  ClaimDraftAttachmentsParams.fromFile(File image) {
    this.name = basename(image.path);
    List<int> imageBytes = image.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    this.base64 = base64Image;
  }

  ClaimDraftAttachmentsParams.fromClaimDraftFile(ClaimDraftFile image) {
    this.name = basename(image.attachment.path);
    List<int> imageBytes = image.attachment.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    this.base64 = base64Image;
  }

  Map<String, dynamic> toJson() => _$ClaimDraftAttachmentsParamsToJson(this);

}
