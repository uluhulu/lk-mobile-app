// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_claims_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchClaimsEntity _$SearchClaimsEntityFromJson(Map<String, dynamic> json) =>
    SearchClaimsEntity(
      data: (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
