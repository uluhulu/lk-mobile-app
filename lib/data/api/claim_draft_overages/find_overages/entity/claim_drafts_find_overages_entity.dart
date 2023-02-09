// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:mkk/data/api/dictionary/filials/entity/dictionary_filials_entity.dart';

part 'claim_drafts_find_overages_entity.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimDraftsFindOveragesEntity {
  final List<ClaimDraftFindOverageData> data;
  final Meta meta;
  final Links? links;
  final OverageFilter filter;

  ClaimDraftsFindOveragesEntity({
    required this.data,
    required this.meta,
    this.links,
    required this.filter,
  });

  factory ClaimDraftsFindOveragesEntity.fromJson(Map<String, dynamic> json) =>
      _$ClaimDraftsFindOveragesEntityFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class OverageFilter {
  final List<String>? manufacturers;

  OverageFilter({
    this.manufacturers,
  });

  factory OverageFilter.fromJson(Map<String, dynamic> json) =>
      _$OverageFilterFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimDraftFindOverageData {
  final String code;
  final String guid;
  final String name;
  final String? country;
  final String manufacturer;
  final String nds;
  final List<OverageSeries> series;

  ClaimDraftFindOverageData({
    required this.code,
    required this.guid,
    required this.name,
    this.country,
    required this.manufacturer,
    required this.nds,
    required this.series,
  });

  factory ClaimDraftFindOverageData.fromJson(Map<String, dynamic> json) =>
      _$ClaimDraftFindOverageDataFromJson(json);

  ClaimDraftFindOverageData copyWith({
    String? code,
    String? guid,
    String? name,
    String? country,
    String? manufacturer,
    String? nds,
    List<OverageSeries>? series,
  }) {
    return ClaimDraftFindOverageData(
      code: code ?? this.code,
      guid: guid ?? this.guid,
      name: name ?? this.name,
      country: country ?? this.country,
      manufacturer: manufacturer ?? this.manufacturer,
      nds: nds ?? this.nds,
      series: series ?? this.series,
    );
  }
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class OverageSeries {
  final String code;
  final String guid;
  final String name;
  final bool isMarking;

  OverageSeries({
    required this.code,
    required this.guid,
    required this.name,
    required this.isMarking,
  });

  factory OverageSeries.fromJson(Map<String, dynamic> json) =>
      _$OverageSeriesFromJson(json);
}
