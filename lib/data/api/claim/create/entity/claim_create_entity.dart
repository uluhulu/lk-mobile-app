import 'package:json_annotation/json_annotation.dart';

part 'claim_create_entity.g.dart';

@JsonSerializable(createToJson: false)
class ClaimCreateEntity {
  final bool success;
  final List<Claims> claims;

  ClaimCreateEntity({
    required this.success,
    required this.claims,
  });

  factory ClaimCreateEntity.fromJson(Map<String, dynamic> json) =>
      _$ClaimCreateEntityFromJson(json);
}

@JsonSerializable(createToJson: false)
class Claims {
  final String claimdoc;
  final String claimdate;
  final List<ClaimGoods> claimGoods;

  Claims({
    required this.claimdoc,
    required this.claimdate,
    required this.claimGoods,
  });

  factory Claims.fromJson(Map<String, dynamic> json) => _$ClaimsFromJson(json);
}

@JsonSerializable(createToJson: false)
class ClaimGoods {
  final String ean;
  final String ser;
  final String expirationDate;
  final int claimCount;
  final bool mark;
  final int claimtype;
  final int wish;
  final double price;

  ClaimGoods({
    required this.ean,
    required this.ser,
    required this.expirationDate,
    required this.claimCount,
    required this.mark,
    required this.claimtype,
    required this.wish,
    required this.price,
  });

  factory ClaimGoods.fromJson(Map<String, dynamic> json) =>
      _$ClaimGoodsFromJson(json);
}
