import 'package:json_annotation/json_annotation.dart';

part 'claim_update_entity.g.dart';

@JsonSerializable(createToJson: false)
class ClaimUpdateEntity {
  final bool success;

  ClaimUpdateEntity({
    required this.success,
  });

  factory ClaimUpdateEntity.fromJson(Map<String, dynamic> json) =>
      _$ClaimUpdateEntityFromJson(json);
}
