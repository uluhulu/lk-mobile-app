import 'package:json_annotation/json_annotation.dart';

part 'claim_find_params.g.dart';

@JsonSerializable(createFactory: false)
class ClaimFindParams {
  final bool for_the_period;
  final Period period;
  final List<ClaimDocs> claimdocs;

  ClaimFindParams({
    required this.for_the_period,
    required this.period,
    required this.claimdocs,
  });

  Map<String, dynamic> toJson() => _$ClaimFindParamsToJson(this);
}

@JsonSerializable(createFactory: false)
class Period {
  final String from;
  final String to;

  Period({
    required this.from,
    required this.to,
  });

  Map<String, dynamic> toJson() => _$PeriodToJson(this);
}

@JsonSerializable(createFactory: false)
class ClaimDocs {
  final String claimdoc;
  final String claimdate;

  ClaimDocs({
    required this.claimdoc,
    required this.claimdate,
  });

  Map<String, dynamic> toJson() => _$ClaimDocsToJson(this);
}

@JsonSerializable(createFactory: false)
class ClaimFindHeaderParam {
  final String company;

  ClaimFindHeaderParam({
    required this.company,
  });

  Map<String, dynamic> toJson() => _$ClaimFindHeaderParamToJson(this);
}
