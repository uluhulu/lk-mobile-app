// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoices_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoicesListEntity _$InvoicesListEntityFromJson(Map<String, dynamic> json) =>
    InvoicesListEntity(
      data: (json['data'] as List<dynamic>)
          .map((e) => InvoicesData.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: Links.fromJson(json['links'] as Map<String, dynamic>),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      filter: Filter.fromJson(json['filter'] as Map<String, dynamic>),
      markingStatuses: (json['marking_statuses'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      appliedFilters: AppliedFilters.fromJson(
          json['applied_filters'] as Map<String, dynamic>),
      isEdo: json['isEdo'] as bool,
    );

InvoicesData _$InvoicesDataFromJson(Map<String, dynamic> json) => InvoicesData(
      guid: json['guid'] as String,
      date: json['date'] as String?,
      hasClaims: json['has_claims'] as bool,
      isMarking: json['is_marking'] as bool,
      sum: (json['sum'] as num).toDouble(),
      cargoName: json['cargo_name'] as String,
      cargoAddress: json['cargo_address'] as String,
      edo: json['edo'] as String,
      file: json['file'] as String,
      filterKey: json['filter_key'] as String,
      marketplaceName: json['marketplace_name'] as String,
      marketplaceNumber: json['marketplace_number'] as String,
      marketplaceStatus: json['marketplace_status'] as String,
      customerOrderNumber: json['customer_order_number'] as String,
      claims: (json['claims'] as List<dynamic>)
          .map((e) => Claims.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Claims _$ClaimsFromJson(Map<String, dynamic> json) => Claims(
      uuid: json['uuid'] as String,
      number: json['number'] as String,
      date: json['date'] as String?,
    );

Filter _$FilterFromJson(Map<String, dynamic> json) => Filter(
      addresses: (json['addresses'] as List<dynamic>)
          .map((e) => Addresses.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Addresses _$AddressesFromJson(Map<String, dynamic> json) => Addresses(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      parentUuid: json['parentUuid'] as String,
      parentName: json['parentName'] as String,
    );

AppliedFilters _$AppliedFiltersFromJson(Map<String, dynamic> json) =>
    AppliedFilters(
      dateFrom: json['date_from'] as String?,
      dateTo: json['date_to'] as String?,
      addressFilter: json['address_filter'] as String,
      isMarking: json['is_marking'] as bool,
      markingStatus: json['marking_status'] as String,
    );
