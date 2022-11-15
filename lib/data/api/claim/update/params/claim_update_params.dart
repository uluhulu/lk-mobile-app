import 'package:json_annotation/json_annotation.dart';

part 'claim_update_params.g.dart';

@JsonSerializable(createFactory: false)
class ClaimUpdateParams {
  String claimdoc;
  String claimdate;
  List<ClaimGoods> claimGoods;

  ClaimUpdateParams({
    required this.claimdoc,
    required this.claimdate,
    required this.claimGoods,
  });

  Map<String, dynamic> toJson() => _$ClaimUpdateParamsToJson(this);
}

@JsonSerializable(createFactory: false)
class ClaimGoods {
  String ean;
  String ser;
  String expirationDate;
  int claimCount;
  bool mark;
  int claimtype;
  int wish;
  String comment;
  double price;
  List<Attachments>? attachments;

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
    this.attachments,
  });

  Map<String, dynamic> toJson() => _$ClaimGoodsToJson(this);
}

@JsonSerializable(createFactory: false)
class Attachments {
  String name;
  String content;

  Attachments({
    required this.name,
    required this.content,
  });

  Map<String, dynamic> toJson() => _$AttachmentsToJson(this);
}
