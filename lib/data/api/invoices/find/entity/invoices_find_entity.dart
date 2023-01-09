import 'package:json_annotation/json_annotation.dart';
import 'package:mkk/data/api/invoices/list/entity/invoices_entity.dart';

part 'invoices_find_entity.g.dart';

@JsonSerializable(createToJson: false)
class InvoicesFindEntity {
  final List<InvoicesData> data;
  InvoicesFindEntity({
    required this.data,
  });

  factory InvoicesFindEntity.fromJson(Map<String, dynamic> json) =>
      _$InvoicesFindEntityFromJson(json);
}
