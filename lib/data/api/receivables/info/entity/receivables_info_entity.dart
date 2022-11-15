import 'package:json_annotation/json_annotation.dart';

part 'receivables_info_entity.g.dart';

@JsonSerializable(createToJson: false)
class ReceivablesInfoEntity {
  final ReceivablesData data;

  ReceivablesInfoEntity({
    required this.data,
  });

  factory ReceivablesInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$ReceivablesInfoEntityFromJson(json);
}

@JsonSerializable(createToJson: false)
class ReceivablesData {
  @JsonKey(name: 'due_date')
  final DueDate? dueDate;
  @JsonKey(name: 'overdue_period')
  final OverduePeriod? overduePeriod;
  final Map<String, ReceivablesList>? list;

  ReceivablesData({
    required this.dueDate,
    required this.overduePeriod,
    required this.list,
  });

  factory ReceivablesData.fromJson(Map<String, dynamic> json) =>
      _$ReceivablesDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class DueDate {
  final String? date;
  final double sum;

  DueDate({
    this.date,
    required this.sum,
  });

  factory DueDate.fromJson(Map<String, dynamic> json) =>
      _$DueDateFromJson(json);
}

@JsonSerializable(createToJson: false)
class OverduePeriod {
  final int days;
  final String unit;

  OverduePeriod({
    required this.days,
    required this.unit,
  });

  factory OverduePeriod.fromJson(Map<String, dynamic> json) =>
      _$OverduePeriodFromJson(json);
}

@JsonSerializable(createToJson: false)
class ReceivablesList {
  final String category;
  final String label;
  final double sum;
  final int count;
  @JsonKey(name: 'count_label')
  final String countLabel;

  ReceivablesList({
    required this.category,
    required this.label,
    required this.sum,
    required this.count,
    required this.countLabel,
  });

  factory ReceivablesList.fromJson(Map<String, dynamic> json) =>
      _$ReceivablesListFromJson(json);
}
