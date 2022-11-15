import 'package:json_annotation/json_annotation.dart';

part 'receivables_params.g.dart';

@JsonSerializable(createFactory: false)
class ReceivablesParams {
  final int page;
  final int per_page;
  final String category;
  final String sorting;
  final String date_from;
  final String date_to;

  ReceivablesParams({
    required this.page,
    required this.per_page,
    required this.category,
    required this.sorting,
    required this.date_from,
    required this.date_to,
  });

  Map<String, dynamic> toJson() => _$ReceivablesParamsToJson(this);
}
