// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoices_detail_products_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$InvoicesDetailProductsParamsToJson(
    InvoicesDetailProductsParams instance) {
  final val = <String, dynamic>{
    'uuid': instance.uuid,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sorting', instance.sorting);
  writeNotNull('search_query', instance.searchQuery);
  writeNotNull('page', instance.page);
  writeNotNull('per_page', instance.perPage);
  writeNotNull('manufacturer', instance.manufacturer);
  return val;
}
