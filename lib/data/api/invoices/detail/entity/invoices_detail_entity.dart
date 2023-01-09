import 'package:json_annotation/json_annotation.dart';

part 'invoices_detail_entity.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class InvoicesDetailEntity {
  final InvoicesData data;
  final FilterDetail? filter;
  @JsonKey(name: 'is_edo')
  final bool? isEdo;
  @JsonKey(name: 'is_ecom')
  final bool? isEcom;

  InvoicesDetailEntity({
    required this.data,
    this.filter,
    this.isEdo,
    this.isEcom,
  });

  factory InvoicesDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$InvoicesDetailEntityFromJson(json);
}

@JsonSerializable(createToJson: false)
class InvoicesDetailData {
  final InvoicesData invoices;

  InvoicesDetailData({
    required this.invoices,
  });

  factory InvoicesDetailData.fromJson(Map<String, dynamic> json) =>
      _$InvoicesDetailDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class InvoicesData {
  InvoicesDetail invoice;
  InvoicesData({
    required this.invoice,
  });

  factory InvoicesData.fromJson(Map<String, dynamic> json) =>
      _$InvoicesDataFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class InvoicesDetail {
  final String uuid;
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
  final String? filterKey;
  @JsonKey(name: 'marketplace_name')
  final String marketplaceName;
  @JsonKey(name: 'marketplace_number')
  final String marketplaceNumber;
  @JsonKey(name: 'marketplace_status')
  final String marketplaceStatus;
  @JsonKey(name: 'customer_order_number')
  final String customerOrderNumber;
  final List<ClaimsDetail>? claims;
  @JsonKey(name: 'marking_status')
  final MarkingStatus? markingStatus;

  InvoicesDetail({
    required this.uuid,
    this.date,
    required this.hasClaims,
    required this.isMarking,
    required this.sum,
    required this.cargoName,
    required this.cargoAddress,
    required this.edo,
    required this.file,
    this.filterKey,
    required this.marketplaceName,
    required this.marketplaceNumber,
    required this.marketplaceStatus,
    required this.customerOrderNumber,
    this.claims,
    this.markingStatus,
  });

  factory InvoicesDetail.fromJson(Map<String, dynamic> json) =>
      _$InvoicesDetailFromJson(json);
}

@JsonSerializable(createToJson: false)
class ClaimsDetail {
  final String uuid;
  final String? number;
  final String? date;

  ClaimsDetail({
    required this.uuid,
    this.number,
    this.date,
  });

  factory ClaimsDetail.fromJson(Map<String, dynamic> json) =>
      _$ClaimsDetailFromJson(json);
}

@JsonSerializable(createToJson: false)
class MarkingStatus {
  final String name;
  final String description;

  MarkingStatus({
    required this.name,
    required this.description,
  });

  factory MarkingStatus.fromJson(Map<String, dynamic> json) =>
      _$MarkingStatusFromJson(json);
}

@JsonSerializable(createToJson: false)
class FilterDetail {
  final List<String> manufacturers;

  FilterDetail({
    required this.manufacturers,
  });

  factory FilterDetail.fromJson(Map<String, dynamic> json) =>
      _$FilterDetailFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class AppliedFilters {
  @JsonKey(name: 'date_from')
  final String? dateFrom;
  @JsonKey(name: 'date_to')
  final String? dateTo;
  @JsonKey(name: 'address_filter')
  final String? addressFilter;
  @JsonKey(name: 'is_marking')
  final bool? isMarking;
  @JsonKey(name: 'marking_status')
  final String? markingStatus;

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
