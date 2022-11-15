import 'package:json_annotation/json_annotation.dart';

part 'profile_act_params.g.dart';

@JsonSerializable(createFactory: false)
class ProfileActParams {
  @JsonKey(name: 'date_from')
  final String? dateFrom;
  @JsonKey(name: 'date_to')
  final String? dateTo;

  ProfileActParams({
    required this.dateFrom,
    required this.dateTo,
  });

  Map<String, dynamic> toJson() => _$ProfileActParamsToJson(this);
}
