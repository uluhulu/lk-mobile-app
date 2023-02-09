import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart';
import 'dart:convert';

part 'claim_new_attachment_params.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class ClaimsNewAttachmentsParams {
  final String claimUuid;
  final String productUuid;
  final List<AttachmentsParams> attachments;

  ClaimsNewAttachmentsParams({
    required this.claimUuid,
    required this.productUuid,
    required this.attachments,
  });

  Map<String, dynamic> toJson() => _$ClaimsNewAttachmentsParamsToJson(this);
}

@JsonSerializable( createFactory: false,fieldRename: FieldRename.snake,)
class AttachmentsParams {
  String? path;
  String? name;
  String? base64;

  AttachmentsParams({this.name, this.base64});

  AttachmentsParams.fromFile(File image) {
    this.name = basename(image.path);
    List<int> imageBytes = image.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    this.base64 = base64Image;
  }

  Map<String, dynamic> toJson() => _$AttachmentsParamsToJson(this);

}
