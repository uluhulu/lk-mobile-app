import 'package:json_annotation/json_annotation.dart';

part 'profile_info_entity.g.dart';

@JsonSerializable(createToJson: false)
class ProfileInfoEntity {
  final ProfileData data;

  ProfileInfoEntity({
    required this.data,
  });

  factory ProfileInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$ProfileInfoEntityFromJson(json);
}

@JsonSerializable(createToJson: false)
class ProfileData {
  final int id;
  final String name;

  final String email;
  final String role;
  final Client client;

  ProfileData({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.client,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);

  @override
  String toString() {
    return 'ProfileData{id: $id, name: $name, email: $email, role: $role, client: $client}';
  }

  factory ProfileData.empty() => ProfileData(
        id: 0,
        name: '',
        email: '',
        role: '',
        client: Client.empty(),
      );
}

@JsonSerializable(createToJson: false)
class Client {
  final String guid;
  @JsonKey(name: 'last_connect')
  final String lastConnect;
  @JsonKey(name: 'filial_id')
  final int filialId;
  final String name;
  @JsonKey(name: 'short_name')
  final String shortName;
  final String sid;
  @JsonKey(name: 'super_short_name')
  final String superShortName;
  final String inn;
  final String email;
  @JsonKey(name: 'is_main')
  final bool isMain;
  @JsonKey(name: 'company_group_guid')
  final String companyGroupGuid;
  @JsonKey(name: 'company_group_name')
  final String companyGroupName;
  final Manager? manager;
  @JsonKey(name: 'office_manager')
  final Manager? officeManager;
  final Map<String, Cargo> cargo;

  Client({
    required this.guid,
    required this.lastConnect,
    required this.filialId,
    required this.name,
    required this.shortName,
    required this.sid,
    required this.superShortName,
    required this.inn,
    required this.email,
    required this.isMain,
    required this.companyGroupGuid,
    required this.companyGroupName,
    required this.manager,
    required this.officeManager,
    required this.cargo,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  factory Client.empty() => Client(
        guid: '',
        lastConnect: '',
        filialId: 0,
        name: '',
        shortName: '',
        sid: '',
        superShortName: '',
        inn: '',
        email: '',
        isMain: false,
        companyGroupGuid: '',
        companyGroupName: '',
        manager: null,
        officeManager: null,
        cargo: {},
      );
}

@JsonSerializable(createToJson: false)
class Manager {
  final String? name;
  final String? email;
  final String? phone;
  @JsonKey(name: 'phone_org')
  final String? phoneOrg;
  @JsonKey(name: 'phone_short')
  final String? phoneShort;
  @JsonKey(name: 'phone_user')
  final String? phoneUser;

  Manager({
    this.name,
    this.email,
    this.phone,
    this.phoneOrg,
    this.phoneShort,
    this.phoneUser,
  });

  factory Manager.fromJson(Map<String, dynamic> json) =>
      _$ManagerFromJson(json);
}

@JsonSerializable(createToJson: false)
class Cargo {
  final String name;
  @JsonKey(name: 'short_name')
  final String shortName;
  final String address;

  Cargo({
    required this.name,
    required this.shortName,
    required this.address,
  });

  factory Cargo.fromJson(Map<String, dynamic> json) => _$CargoFromJson(json);
}
