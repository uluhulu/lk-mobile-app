import 'package:json_annotation/json_annotation.dart';

part 'claim_drafts_send_entity.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimDraftsSendEntity {
  final List<ClaimsSendData> claims;

  ClaimDraftsSendEntity({
    required this.claims,
  });

  factory ClaimDraftsSendEntity.fromJson(Map<String, dynamic> json) =>
      _$ClaimDraftsSendEntityFromJson(json);
}

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class ClaimsSendData {
  final String number;
  final String guid;
  final String date;

  ClaimsSendData({
    required this.number,
    required this.guid,
    required this.date,
  });

  factory ClaimsSendData.fromJson(Map<String, dynamic> json) =>
      _$ClaimsSendDataFromJson(json);
}
