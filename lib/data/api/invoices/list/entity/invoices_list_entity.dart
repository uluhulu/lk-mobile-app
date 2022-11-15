import 'package:json_annotation/json_annotation.dart';

import '../../../dictionary/filials/entity/dictionary_filials_entity.dart';

part 'invoices_list_entity.g.dart';

@JsonSerializable(createToJson: false)
class InvoicesListEntity {
  final List<InvoicesData> data;
  final Links links;
  final Meta meta;
  final Filter filter;
  @JsonKey(name: 'marking_statuses')
  final List<String> markingStatuses;
  @JsonKey(name: 'applied_filters')
  final AppliedFilters appliedFilters;
  final bool isEdo;

  InvoicesListEntity({
    required this.data,
    required this.links,
    required this.meta,
    required this.filter,
    required this.markingStatuses,
    required this.appliedFilters,
    required this.isEdo,
  });

  factory InvoicesListEntity.fromJson(Map<String, dynamic> json) =>
      _$InvoicesListEntityFromJson(json);
}

@JsonSerializable(createToJson: false)
class InvoicesData {
  final String guid;
  final String? date;
  @JsonKey(name: 'has_claims')
  final bool hasClaims;
  @JsonKey(name: 'is_marking')
  final bool isMarking;
  final double sum;
  @JsonKey(name: 'cargo_name')
  final String cargoName;
  @JsonKey(name: 'cargo_address')
  final String cargoAddress;
  final String edo;
  final String file;
  @JsonKey(name: 'filter_key')
  final String filterKey;
  @JsonKey(name: 'marketplace_name')
  final String marketplaceName;
  @JsonKey(name: 'marketplace_number')
  final String marketplaceNumber;
  @JsonKey(name: 'marketplace_status')
  final String marketplaceStatus;
  @JsonKey(name: 'customer_order_number')
  final String customerOrderNumber;
  final List<Claims> claims;

  InvoicesData({
    required this.guid,
    this.date,
    required this.hasClaims,
    required this.isMarking,
    required this.sum,
    required this.cargoName,
    required this.cargoAddress,
    required this.edo,
    required this.file,
    required this.filterKey,
    required this.marketplaceName,
    required this.marketplaceNumber,
    required this.marketplaceStatus,
    required this.customerOrderNumber,
    required this.claims,
  });

  factory InvoicesData.fromJson(Map<String, dynamic> json) =>
      _$InvoicesDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class Claims {
  final String uuid;
  final String number;
  final String? date;

  Claims({
    required this.uuid,
    required this.number,
    this.date,
  });

  factory Claims.fromJson(Map<String, dynamic> json) => _$ClaimsFromJson(json);
}

@JsonSerializable(createToJson: false)
class Filter {
  final List<Addresses> addresses;

  Filter({
    required this.addresses,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);
}

@JsonSerializable(createToJson: false)
class Addresses {
  final String uuid;
  final String name;
  final String parentUuid;
  final String parentName;

  Addresses({
    required this.uuid,
    required this.name,
    required this.parentUuid,
    required this.parentName,
  });

  factory Addresses.fromJson(Map<String, dynamic> json) =>
      _$AddressesFromJson(json);
}

@JsonSerializable(createToJson: false)
class AppliedFilters {
  @JsonKey(name: 'date_from')
  final String? dateFrom;
  @JsonKey(name: 'date_to')
  final String? dateTo;
  @JsonKey(name: 'address_filter')
  final String addressFilter;
  @JsonKey(name: 'is_marking')
  final bool isMarking;
  @JsonKey(name: 'marking_status')
  final String markingStatus;

  AppliedFilters({
    this.dateFrom,
    this.dateTo,
    required this.addressFilter,
    required this.isMarking,
    required this.markingStatus,
  });

  factory AppliedFilters.fromJson(Map<String, dynamic> json) =>
      _$AppliedFiltersFromJson(json);
}
