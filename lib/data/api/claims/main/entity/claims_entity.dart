// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import '../../../dictionary/filials/entity/dictionary_filials_entity.dart';
import '../../../invoices/list/entity/invoices_entity.dart';

part 'claims_entity.g.dart';

@JsonSerializable(createToJson: false)
class ClaimsEntity {
  final List<Data> data;
  final Links? links;
  final Meta meta;
  final ClaimsFilter filter;

  ClaimsEntity({
    required this.data,
    this.links,
    required this.meta,
    required this.filter,
  });

  void sort([int Function(Data, Data)? compare]) {
    data.sort(compare);
  }

  ClaimsEntity get reversed {
    return ClaimsEntity(
      data: data.reversed.toList(),
      links: links,
      meta: meta,
      filter: filter,
    );
  }

  factory ClaimsEntity.fromJson(Map<String, dynamic> json) =>
      _$ClaimsEntityFromJson(json);
}

@JsonSerializable(createToJson: false)
class ClaimsFilter {
  final List<Addresses> addresses;
  final List<String>? statuses;
  ClaimsFilter({
    required this.addresses,
    this.statuses,
  });

  factory ClaimsFilter.fromJson(Map<String, dynamic> json) =>
      _$ClaimsFilterFromJson(json);
}

@JsonSerializable(createToJson: false)
class Data {
  final String uuid;
  final String number;
  final String date;
  final String status;
  @JsonKey(name: 'has_agreement')
  final bool hasAgreement;
  final bool accept;
  @JsonKey(name: 'in_number')
  final String inNumber;
  final String? comment;
  final double? summary;
  final ClaimsCargo cargo;
  final ClaimsInvoice invoice;

  Data({
    required this.uuid,
    required this.number,
    required this.date,
    required this.status,
    required this.hasAgreement,
    required this.accept,
    required this.inNumber,
    this.comment,
    this.summary,
    required this.cargo,
    required this.invoice,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@JsonSerializable(createToJson: false)
class ClaimsCargo {
  final String uuid;
  final String name;
  final String address;
  ClaimsCargo({
    required this.uuid,
    required this.name,
    required this.address,
  });

  factory ClaimsCargo.fromJson(Map<String, dynamic> json) =>
      _$ClaimsCargoFromJson(json);
}

@JsonSerializable(createToJson: false)
class ClaimsInvoice {
  final String uuid;
  final double sum;
  final String number;
  final String date;
  ClaimsInvoice({
    required this.uuid,
    required this.sum,
    required this.number,
    required this.date,
  });

  factory ClaimsInvoice.fromJson(Map<String, dynamic> json) =>
      _$ClaimsInvoiceFromJson(json);
}

@JsonSerializable(createToJson: false)
class ClaimsLinks {
  final String? url;
  final String? label;
  final bool? active;
  ClaimsLinks({
    this.url,
    this.label,
    this.active,
  });

  factory ClaimsLinks.fromJson(Map<String, dynamic> json) =>
      _$ClaimsLinksFromJson(json);
}
