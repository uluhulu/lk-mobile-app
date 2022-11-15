import 'package:mkk/data/api/auth/login/entity/auth_login_entity.dart';
import 'package:mkk/data/api/profile/info/entity/profile_info_entity.dart';

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
}
