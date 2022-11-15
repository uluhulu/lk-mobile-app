// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_find_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ClaimFindParamsToJson(ClaimFindParams instance) =>
    <String, dynamic>{
      'for_the_period': instance.for_the_period,
      'period': instance.period,
      'claimdocs': instance.claimdocs,
    };

Map<String, dynamic> _$PeriodToJson(Period instance) => <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
    };

Map<String, dynamic> _$ClaimDocsToJson(ClaimDocs instance) => <String, dynamic>{
      'claimdoc': instance.claimdoc,
      'claimdate': instance.claimdate,
    };

Map<String, dynamic> _$ClaimFindHeaderParamToJson(
        ClaimFindHeaderParam instance) =>
    <String, dynamic>{
      'company': instance.company,
    };
