// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'invoices_detail_params.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: false)
class InvoicesDetailParams {
  final String uuid;
  final int? page;
  final int? perPage;

  InvoicesDetailParams({
    required this.uuid,
    this.page,
    this.perPage,
  });

  Map<String, dynamic> toJson() => _$InvoicesDetailParamsToJson(this);

  InvoicesDetailParams copyWith({
    String? uuid,
    int? page,
    int? perPage,
  }) {
    return InvoicesDetailParams(
      uuid: uuid ?? this.uuid,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
    );
  }
}
