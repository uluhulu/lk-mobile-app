// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileInfoEntity _$ProfileInfoEntityFromJson(Map<String, dynamic> json) =>
    ProfileInfoEntity(
      data: ProfileData.fromJson(json['data'] as Map<String, dynamic>),
    );

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      client: Client.fromJson(json['client'] as Map<String, dynamic>),
    );

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      guid: json['guid'] as String,
      lastConnect: json['last_connect'] as String,
      filialId: json['filial_id'] as int,
      name: json['name'] as String,
      shortName: json['short_name'] as String,
      sid: json['sid'] as String,
      superShortName: json['super_short_name'] as String,
      inn: json['inn'] as String,
      email: json['email'] as String,
      isMain: json['is_main'] as bool,
      companyGroupGuid: json['company_group_guid'] as String,
      companyGroupName: json['company_group_name'] as String,
      manager: json['manager'] == null
          ? null
          : Manager.fromJson(json['manager'] as Map<String, dynamic>),
      officeManager: json['office_manager'] == null
          ? null
          : Manager.fromJson(json['office_manager'] as Map<String, dynamic>),
      cargo: (json['cargo'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Cargo.fromJson(e as Map<String, dynamic>)),
      ),
    );

Manager _$ManagerFromJson(Map<String, dynamic> json) => Manager(
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      phoneOrg: json['phone_org'] as String?,
      phoneShort: json['phone_short'] as String?,
      phoneUser: json['phone_user'] as String?,
      mail: json['mail'] as String?,
    );

Cargo _$CargoFromJson(Map<String, dynamic> json) => Cargo(
      name: json['name'] as String,
      shortName: json['short_name'] as String,
      address: json['address'] as String,
    );
