// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receivables_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceivablesEntity _$ReceivablesEntityFromJson(Map<String, dynamic> json) =>
    ReceivablesEntity(
      data: (json['data'] as List<dynamic>)
          .map((e) => ReceivablesData.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: Links.fromJson(json['links'] as Map<String, dynamic>),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

ReceivablesData _$ReceivablesDataFromJson(Map<String, dynamic> json) =>
    ReceivablesData(
      guid: json['guid'] as String,
      type: json['type'] as String,
      date: json['date'] as String?,
      number: json['number'] as String,
      sum: (json['sum'] as num).toDouble(),
      paymentDate: json['paymentDate'] as String?,
      remains: (json['remains'] as num).toDouble(),
      overdueDays: json['overdue_days'] as int,
      leftDays: json['left_days'] as int,
      postponement: json['postponement'] as int,
      category: json['category'] as int,
      categoryDisplay: json['category_display'] as String,
      paid: (json['paid'] as num).toDouble(),
      docDays: json['docDays'] as int,
    );
