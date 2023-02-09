// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:mkk/data/api/dictionary/filials/entity/dictionary_filials_entity.dart';

part 'invoices_detail_products_entity.g.dart';

@JsonSerializable(createToJson: false)
class InvoicesDetailProductsEntity {
  final List<InvoicesDetailProductData> data;
  final Links? links;
  final Meta meta;
  final InvoicesProductsFilter? filter;

  InvoicesDetailProductsEntity({
    required this.data,
    this.links,
    required this.meta,
    this.filter,
  });

  factory InvoicesDetailProductsEntity.fromJson(Map<String, dynamic> json) =>
      _$InvoicesDetailProductsEntityFromJson(json);
}

@JsonSerializable(createToJson: false)
class InvoicesDetailProductData {
  final String uuid;
  final String code;
  final String name;
  final String manufacturer;
  final int quantity;
  final int pack;
  final int nds;
  final double price;
  final double sum;
  @JsonKey(name: 'sum_nds')
  final double sumNds;
  @JsonKey(name: 'special_price')
  final double specialPrice;
  final InvoicesDetailSeries? series;
  InvoicesDetailProductData({
    required this.uuid,
    required this.code,
    required this.name,
    required this.manufacturer,
    required this.quantity,
    required this.pack,
    required this.nds,
    required this.price,
    required this.sum,
    required this.sumNds,
    required this.specialPrice,
    this.series,
  });

  factory InvoicesDetailProductData.fromJson(Map<String, dynamic> json) =>
      _$InvoicesDetailProductDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class InvoicesDetailSeries {
  final String? uuid;
  final String? name;
  @JsonKey(name: 'is_marking')
  final bool? isMarking;

  InvoicesDetailSeries({
    this.uuid,
    this.name,
    this.isMarking,
  });

  factory InvoicesDetailSeries.fromJson(Map<String, dynamic> json) =>
      _$InvoicesDetailSeriesFromJson(json);
}

@JsonSerializable(createToJson: false)
class InvoicesProductsFilter {
  final List<String>? manufacturers;

  InvoicesProductsFilter({this.manufacturers});

  factory InvoicesProductsFilter.fromJson(Map<String, dynamic> json) =>
      _$InvoicesProductsFilterFromJson(json);
}
