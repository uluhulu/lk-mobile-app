import 'package:json_annotation/json_annotation.dart';

part 'claims_detail_products_entity.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimsDetailProductsEntity {
  final List<ClaimsProductsData> data;

  ClaimsDetailProductsEntity({
    required this.data,
  });

  factory ClaimsDetailProductsEntity.fromJson(Map<String, dynamic> json) =>
      _$ClaimsDetailProductsEntityFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimsProductsData {
  final String uuid;
  final String code;
  final String name;
  final String? seriesName;
  final String? claimTypeName;
  final String? comment;
  final String? conclusion;
  final double? price;
  final double? summary;
  final int? quantity;
  final int? claimQuantity;
  final List<Attachment>? attachment;

  ClaimsProductsData({
    required this.uuid,
    required this.code,
    required this.name,
    this.seriesName,
    this.claimTypeName,
    this.comment,
    this.conclusion,
    this.price,
    this.summary,
    this.quantity,
    this.claimQuantity,
    this.attachment,
  });

  factory ClaimsProductsData.fromJson(Map<String, dynamic> json) =>
      _$ClaimsProductsDataFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class Attachment {
  final String? name;
  final String? path;
  final String? url;

  Attachment({
    this.name,
    this.path,
    this.url,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);
}
