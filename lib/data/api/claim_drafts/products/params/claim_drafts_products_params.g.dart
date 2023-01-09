// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_drafts_products_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ClaimDraftsProductsParamsToJson(
    ClaimDraftsProductsParams instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('per_page', instance.perPage);
  writeNotNull('is_selected', instance.isSelected);
  writeNotNull('search_query', instance.searchQuery);
  return val;
}
