// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claims_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimsEntity _$ClaimsEntityFromJson(Map<String, dynamic> json) => ClaimsEntity(
      data: (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: json['links'] == null
          ? null
          : Links.fromJson(json['links'] as Map<String, dynamic>),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      filter: ClaimsFilter.fromJson(json['filter'] as Map<String, dynamic>),
    );

ClaimsFilter _$ClaimsFilterFromJson(Map<String, dynamic> json) => ClaimsFilter(
      addresses: (json['addresses'] as List<dynamic>)
          .map((e) => Addresses.fromJson(e as Map<String, dynamic>))
          .toList(),
      statuses: (json['statuses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      uuid: json['uuid'] as String,
      number: json['number'] as String,
      date: json['date'] as String,
      status: json['status'] as String,
      hasAgreement: json['has_agreement'] as bool,
      accept: json['accept'] as bool,
      inNumber: json['in_number'] as String,
      comment: json['comment'] as String?,
      summary: (json['summary'] as num?)?.toDouble(),
      cargo: ClaimsCargo.fromJson(json['cargo'] as Map<String, dynamic>),
      invoice: ClaimsInvoice.fromJson(json['invoice'] as Map<String, dynamic>),
    );

ClaimsCargo _$ClaimsCargoFromJson(Map<String, dynamic> json) => ClaimsCargo(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
    );

ClaimsInvoice _$ClaimsInvoiceFromJson(Map<String, dynamic> json) =>
    ClaimsInvoice(
      uuid: json['uuid'] as String,
      sum: (json['sum'] as num).toDouble(),
      number: json['number'] as String,
      date: json['date'] as String,
    );

ClaimsLinks _$ClaimsLinksFromJson(Map<String, dynamic> json) => ClaimsLinks(
      url: json['url'] as String?,
      label: json['label'] as String?,
      active: json['active'] as bool?,
    );
