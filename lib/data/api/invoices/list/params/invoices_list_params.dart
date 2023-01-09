// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'invoices_list_params.g.dart';

enum InvoicesSorting {
  @JsonValue('date DESC')
  desk,
  @JsonValue('date ASC')
  asc,
}

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class InvoicesListParams {
  @JsonKey(includeIfNull: false)
  final int? page;
  @JsonKey(includeIfNull: false)
  final int? perPage;
  @JsonKey(includeIfNull: false)
  final InvoicesSorting? sorting;
  @JsonKey(includeIfNull: false)
  final String? markingStatus;
  @JsonKey(includeIfNull: false)
  final String? address;
  @JsonKey(includeIfNull: false)
  final bool? isMarking;
  final String dateFrom;
  final String dateTo;

  InvoicesListParams({
    this.page,
    this.perPage,
    this.sorting,
    this.markingStatus,
    this.address,
    this.isMarking,
    required this.dateFrom,
    required this.dateTo,
  });

  Map<String, dynamic> toJson() => _$InvoicesListParamsToJson(this);

  InvoicesListParams copyWith({
    int? page,
    int? perPage,
    InvoicesSorting? sorting,
    String? markingStatus,
    String? address,
    bool? isMarking,
    String? dateFrom,
    String? dateTo,
  }) {
    return InvoicesListParams(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      sorting: sorting ?? this.sorting,
      markingStatus: markingStatus ?? this.markingStatus,
      address: address ?? this.address,
      isMarking: isMarking ?? this.isMarking,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
    );
  }
}
