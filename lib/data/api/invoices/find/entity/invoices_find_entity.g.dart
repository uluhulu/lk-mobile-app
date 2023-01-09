// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoices_find_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoicesFindEntity _$InvoicesFindEntityFromJson(Map<String, dynamic> json) =>
    InvoicesFindEntity(
      data: (json['data'] as List<dynamic>)
          .map((e) => InvoicesData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
