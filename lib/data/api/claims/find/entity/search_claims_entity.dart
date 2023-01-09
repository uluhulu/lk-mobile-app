import 'package:json_annotation/json_annotation.dart';

import '../../main/entity/claims_entity.dart';

part 'search_claims_entity.g.dart';

@JsonSerializable(createToJson: false)
class SearchClaimsEntity {
  final List<Data> data;

  SearchClaimsEntity({
    required this.data,
  });

  factory SearchClaimsEntity.fromJson(Map<String, dynamic> json) =>
      _$SearchClaimsEntityFromJson(json);
}
