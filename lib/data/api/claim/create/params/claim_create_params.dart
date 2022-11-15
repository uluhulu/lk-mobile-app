import 'package:json_annotation/json_annotation.dart';

part 'claim_create_params.g.dart';

@JsonSerializable(createFactory: false)
class ClaimCreateParams {
  final String saledoc;
  final String saledate;
  final List<ClaimGoods> claimGoods;

  ClaimCreateParams({
    required this.saledoc,
    required this.saledate,
    required this.claimGoods,
  });

  Map<String, dynamic> toJson() => _$ClaimCreateParamsToJson(this);
}

@JsonSerializable(createFactory: false)
class ClaimGoods {
  final String ean;
  final String ser;
  final String expirationDate;
  final int claimCount;
  final bool mark;
  final int claimtype;
  final int wish;
  final String comment;
  final double price;
  final List<Attachments> attachments;

  ClaimGoods({
    required this.ean,
    required this.ser,
    required this.expirationDate,
    required this.claimCount,
    required this.mark,
    required this.claimtype,
    required this.wish,
    required this.comment,
    required this.price,
    required this.attachments,
  });

  Map<String, dynamic> toJson() => _$ClaimGoodsToJson(this);
}

@JsonSerializable(createFactory: false)
class Attachments {
  final String name;
  final String content;

  Attachments({
    required this.name,
    required this.content,
  });

  Map<String, dynamic> toJson() => _$AttachmentsToJson(this);
}
