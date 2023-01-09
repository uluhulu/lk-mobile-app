// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoices_list_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$InvoicesListParamsToJson(InvoicesListParams instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('per_page', instance.perPage);
  writeNotNull('sorting', _$InvoicesSortingEnumMap[instance.sorting]);
  writeNotNull('marking_status', instance.markingStatus);
  writeNotNull('address', instance.address);
  writeNotNull('is_marking', instance.isMarking);
  val['date_from'] = instance.dateFrom;
  val['date_to'] = instance.dateTo;
  return val;
}

const _$InvoicesSortingEnumMap = {
  InvoicesSorting.desk: 'date DESC',
  InvoicesSorting.asc: 'date ASC',
};
