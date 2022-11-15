import 'package:json_annotation/json_annotation.dart';

part 'claim_find_entity.g.dart';

@JsonSerializable(createToJson: false)
class ClaimFindEntity {
  final List<ClaimDocs> claimdocs;

  ClaimFindEntity({
    required this.claimdocs,
  });

  factory ClaimFindEntity.fromJson(Map<String, dynamic> json) =>
      _$ClaimFindEntityFromJson(json);
}

@JsonSerializable(createToJson: false)
class ClaimDocs {
  final String claimdoc;
  final String claimdate;
  final String saledoc;
  final String saledate;
  final String turnoverdoc;
  final String turnoverdate;
  final String status;
  final List<ClaimGoods> claimGoods;

  ClaimDocs({
    required this.claimdoc,
    required this.claimdate,
    required this.saledoc,
    required this.saledate,
    required this.turnoverdoc,
    required this.turnoverdate,
    required this.status,
    required this.claimGoods,
  });

  factory ClaimDocs.fromJson(Map<String, dynamic> json) =>
      _$ClaimDocsFromJson(json);
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
  final String resolution;
  final String comment;
  final double price;

  ClaimGoods({
    required this.ean,
    required this.ser,
    required this.expirationDate,
    required this.claimCount,
    required this.mark,
    required this.claimtype,
    required this.wish,
    required this.resolution,
    required this.comment,
    required this.price,
  });

  factory ClaimGoods.fromJson(Map<String, dynamic> json) =>
      _$ClaimGoodsFromJson(json);
}


/*
Возможные значения типов претензии:
ClaimType = 1 Излишки
ClaimType = 2 Недостача
ClaimType = 3 Бой
ClaimType = 4 Брак
ClaimType = 5 Забракованная серия
ClaimType = 6 Ошибка заказа
ClaimType = 7 Срок годности
ClaimType = 8 Ошибка маркировки
ClaimType = 9 Пересорт по номенклатуре;
ClaimType = 10 Пересорт по серии;
ClaimType = 21 Отказ клиента (E-com) – только для заказов e-com
ClaimType = 0 Другое (пустая ссылка)
*/