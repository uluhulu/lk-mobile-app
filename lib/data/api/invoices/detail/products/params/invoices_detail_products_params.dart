// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'invoices_detail_products_params.g.dart';

@JsonSerializable(
    createFactory: false, fieldRename: FieldRename.snake, includeIfNull: false)
class InvoicesDetailProductsParams {
  final String uuid;
  final String? sorting;
  final String? searchQuery;
  final int? page;
  final int? perPage;
  final String? manufacturer;

  InvoicesDetailProductsParams({
    required this.uuid,
    this.sorting,
    this.searchQuery,
    this.page,
    this.perPage,
    this.manufacturer,
  });

  Map<String, dynamic> toJson() => _$InvoicesDetailProductsParamsToJson(this);

  InvoicesDetailProductsParams copyWith({
    String? uuid,
    String? sorting,
    String? searchQuery,
    int? page,
    int? perPage,
    String? manufacturer,
  }) {
    return InvoicesDetailProductsParams(
      uuid: uuid ?? this.uuid,
      sorting: sorting ?? this.sorting,
      searchQuery: searchQuery ?? this.searchQuery,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      manufacturer: manufacturer ?? this.manufacturer,
    );
  }
}
