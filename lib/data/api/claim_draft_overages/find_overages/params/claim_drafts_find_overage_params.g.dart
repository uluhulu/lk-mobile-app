// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_drafts_find_overage_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ClaimDraftsFindOveragesParamsToJson(
    ClaimDraftsFindOveragesParams instance) {
  final val = <String, dynamic>{
    'page': instance.page,
    'per_page': instance.perPage,
    'search_query': instance.searchQuery,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('manufacturer', instance.manufacturer);
  return val;
}
