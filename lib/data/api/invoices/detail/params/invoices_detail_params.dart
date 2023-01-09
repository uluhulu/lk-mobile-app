import 'package:json_annotation/json_annotation.dart';

part 'invoices_detail_params.g.dart';

@JsonSerializable(createFactory: false)
class InvoicesDetailParams {
  final String uuid;

  InvoicesDetailParams({
    required this.uuid,
  });

  Map<String, dynamic> toJson() => _$InvoicesDetailParamsToJson(this);
}
