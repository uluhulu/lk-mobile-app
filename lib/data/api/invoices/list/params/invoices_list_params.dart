import 'package:json_annotation/json_annotation.dart';

part 'invoices_list_params.g.dart';

@JsonSerializable(createFactory: false)
class InvoicesListParams {
  final int? page;
  final int? per_page;
  final String? sorting;
  //TODO: переделать поле
  final String? statusMark;
  final String? address;
  final bool? is_marking;
  final String date_from;
  final String date_to;

  InvoicesListParams({
    this.page,
    this.per_page,
    this.sorting,
    this.statusMark,
    this.address,
    this.is_marking,
    required this.date_from,
    required this.date_to,
  });

  Map<String, dynamic> toJson() => _$InvoicesListParamsToJson(this);
}
