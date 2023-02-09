import 'package:json_annotation/json_annotation.dart';

part 'claim_new_attachment_entity.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimsNewAttachmentsEntity {
  final Data data;

  ClaimsNewAttachmentsEntity({required this.data});

  factory ClaimsNewAttachmentsEntity.fromJson(Map<String, dynamic> json) =>
      _$ClaimsNewAttachmentsEntityFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class Data {
  final List<AttachmentsEntity> attachments;
  final List<Errors> errors;

  Data({required this.attachments, required this.errors});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ImageData {
  final AttachmentsEntity data;

  ImageData({required this.data});

  factory ImageData.fromJson(Map<String, dynamic> json) =>
      _$ImageDataFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class AttachmentsEntity {
  String? name;
  String? path;
  String? base64;

  AttachmentsEntity({this.name, this.path, this.base64});

  factory AttachmentsEntity.fromJson(Map<String, dynamic> json) =>
      _$AttachmentsEntityFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class Errors {
  String? name;
  String? message;

  Errors({this.name, this.message});

  factory Errors.fromJson(Map<String, dynamic> json) => _$ErrorsFromJson(json);
}
