// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoices_detail_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$InvoicesDetailParamsToJson(
    InvoicesDetailParams instance) {
  final val = <String, dynamic>{
    'uuid': instance.uuid,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('perPage', instance.perPage);
  return val;
}
