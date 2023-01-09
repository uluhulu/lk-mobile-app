import 'package:json_annotation/json_annotation.dart';

part 'invoices_find_params.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class InvoicesFindParams {
  final String search;
  final String searchBy;
  InvoicesFindParams({
    required this.search,
    required this.searchBy,
  });

  Map<String, dynamic> toJson() => _$InvoicesFindParamsToJson(this);
}
