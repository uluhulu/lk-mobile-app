import 'package:json_annotation/json_annotation.dart';
import 'package:mkk/data/api/claims/main/entity/claims_entity.dart';

part 'claim_detail_entity.g.dart';

@JsonSerializable(createToJson: false)
class ClaimDetailEntity {
  final Data data;

  ClaimDetailEntity({
    required this.data,
  });

  factory ClaimDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$ClaimDetailEntityFromJson(json);
}
