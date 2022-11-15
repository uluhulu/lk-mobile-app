// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receivables_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceivablesInfoEntity _$ReceivablesInfoEntityFromJson(
        Map<String, dynamic> json) =>
    ReceivablesInfoEntity(
      data: ReceivablesData.fromJson(json['data'] as Map<String, dynamic>),
    );

ReceivablesData _$ReceivablesDataFromJson(Map<String, dynamic> json) =>
    ReceivablesData(
      dueDate: json['due_date'] == null
          ? null
          : DueDate.fromJson(json['due_date'] as Map<String, dynamic>),
      overduePeriod: json['overdue_period'] == null
          ? null
          : OverduePeriod.fromJson(
              json['overdue_period'] as Map<String, dynamic>),
      list: (json['list'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, ReceivablesList.fromJson(e as Map<String, dynamic>)),
      ),
    );

DueDate _$DueDateFromJson(Map<String, dynamic> json) => DueDate(
      date: json['date'] as String?,
      sum: (json['sum'] as num).toDouble(),
    );

OverduePeriod _$OverduePeriodFromJson(Map<String, dynamic> json) =>
    OverduePeriod(
      days: json['days'] as int,
      unit: json['unit'] as String,
    );

ReceivablesList _$ReceivablesListFromJson(Map<String, dynamic> json) =>
    ReceivablesList(
      category: json['category'] as String,
      label: json['label'] as String,
      sum: (json['sum'] as num).toDouble(),
      count: json['count'] as int,
      countLabel: json['count_label'] as String,
    );
