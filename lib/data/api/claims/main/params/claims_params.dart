// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'claims_params.g.dart';

enum ClaimsSorting {
  @JsonValue('date DESC')
  desk,
  @JsonValue('date ASC')
  asc,
}

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class ClaimsParams {
  final String dateFrom;
  final String dateTo;
  @JsonKey(includeIfNull: false)
  final int? page;
  @JsonKey(includeIfNull: false)
  final int? perPage;
  @JsonKey(includeIfNull: false)
  final ClaimsSorting? sorting;
  @JsonKey(includeIfNull: false)
  final String? status;
  @JsonKey(includeIfNull: false)
  final String? address;

  ClaimsParams({
    required this.dateFrom,
    required this.dateTo,
    this.page,
    this.perPage,
    this.sorting,
    this.status,
    this.address,
  });

  Map<String, dynamic> toJson() => _$ClaimsParamsToJson(this);

  ClaimsParams copyWith({
    String? dateFrom,
    String? dateTo,
    int? page,
    int? perPage,
    ClaimsSorting? sorting,
    String? status,
    String? address,
  }) {
    return ClaimsParams(
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      sorting: sorting ?? this.sorting,
      status: status ?? this.status,
      address: address ?? this.address,
    );
  }
}
