// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoices_detail_products_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoicesDetailProductsEntity _$InvoicesDetailProductsEntityFromJson(
        Map<String, dynamic> json) =>
    InvoicesDetailProductsEntity(
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              InvoicesDetailProductData.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: json['links'] == null
          ? null
          : Links.fromJson(json['links'] as Map<String, dynamic>),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      filter: json['filter'] == null
          ? null
          : InvoicesProductsFilter.fromJson(
              json['filter'] as Map<String, dynamic>),
    );

InvoicesDetailProductData _$InvoicesDetailProductDataFromJson(
        Map<String, dynamic> json) =>
    InvoicesDetailProductData(
      uuid: json['uuid'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      manufacturer: json['manufacturer'] as String,
      quantity: json['quantity'] as int,
      pack: json['pack'] as int,
      nds: json['nds'] as int,
      price: (json['price'] as num).toDouble(),
      sum: (json['sum'] as num).toDouble(),
      sumNds: (json['sum_nds'] as num).toDouble(),
      specialPrice: (json['special_price'] as num).toDouble(),
      series: json['series'] == null
          ? null
          : InvoicesDetailSeries.fromJson(
              json['series'] as Map<String, dynamic>),
    );

InvoicesDetailSeries _$InvoicesDetailSeriesFromJson(
        Map<String, dynamic> json) =>
    InvoicesDetailSeries(
      uuid: json['uuid'] as String?,
      name: json['name'] as String?,
      isMarking: json['is_marking'] as bool?,
    );

InvoicesProductsFilter _$InvoicesProductsFilterFromJson(
        Map<String, dynamic> json) =>
    InvoicesProductsFilter(
      manufacturers: (json['manufacturers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
