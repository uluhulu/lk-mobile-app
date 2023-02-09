import 'dart:async';

import 'package:mkk/data/api/auth/login/entity/auth_login_entity.dart';
import 'package:mkk/data/api/profile/info/entity/profile_info_entity.dart';

import '../../data/models/user_role_model.dart';

/// Текущий пользователь
abstract class UserRepository {
  String? getAccessToken();

  Future<void> logOut();

  Future<void> setAccount(ProfileData account);

  Future<void> setAuh(AuthData accountAuth);

  String getEmail();

  String getName();

  int getUserId();

  String getShortName();

  String getInn();

  ProfileData get account;

  String? getLocalAuthPin();

  Future<void> setLocalAuthPin(String? pin);

  Future<void> saveUserLogin(String value);

  String? getUserLogin();

  Future<void> saveRegionalCompany(int value);

  int? getRegionalCompany();

  Future<void> savePassword(String password);

  String? getPassword();

  Future<void> saveUserRole(String userRole);

  Future<void> saveUserAccess(List<UserAccess> listUserAccess);

  List<UserAccess> getUserAccess();

  String? getUserRole();

  Duration getLocalTimeOffset();

  void setLocalTimeOffset(Duration offset);
}
