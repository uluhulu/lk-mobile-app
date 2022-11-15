import 'package:json_annotation/json_annotation.dart';

import '../../../dictionary/filials/entity/dictionary_filials_entity.dart';

part 'receivables_entity.g.dart';

@JsonSerializable(createToJson: false)
class ReceivablesEntity {
  final List<ReceivablesData> data;
  final Links links;
  final Meta meta;

  ReceivablesEntity({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory ReceivablesEntity.fromJson(Map<String, dynamic> json) =>
      _$ReceivablesEntityFromJson(json);
}

@JsonSerializable(createToJson: false)
class ReceivablesData {
  final String guid;
  final String type;
  final String? date;
  final String number;
  final double sum;
  final String? paymentDate;
  final double remains;
  @JsonKey(name: 'overdue_days')
  final int overdueDays;
  @JsonKey(name: 'left_days')
  final int leftDays;
  final int postponement;
  final int category;
  @JsonKey(name: 'category_display')
  final String categoryDisplay;
  final double paid;
  final int docDays;

  ReceivablesData({
    required this.guid,
    required this.type,
    this.date,
    required this.number,
    required this.sum,
    this.paymentDate,
    required this.remains,
    required this.overdueDays,
    required this.leftDays,
    required this.postponement,
    required this.category,
    required this.categoryDisplay,
    required this.paid,
    required this.docDays,
  });

  factory ReceivablesData.fromJson(Map<String, dynamic> json) =>
      _$ReceivablesDataFromJson(json);
}
