import 'package:json_annotation/json_annotation.dart';

part 'invoices_detail_products_params.g.dart';

@JsonSerializable(createFactory: false)
class InvoicesDetailProductsParams {
  final String uuid;
  final String? sorting;

  InvoicesDetailProductsParams({
    required this.uuid,
    this.sorting,
  });

  Map<String, dynamic> toJson() => _$InvoicesDetailProductsParamsToJson(this);
}
