import 'package:injectable/injectable.dart';
import 'package:mkk/data/api/auth/login/entity/auth_login_entity.dart';
import 'package:mkk/data/api/profile/info/entity/profile_info_entity.dart';
import 'package:mkk/domain/repositories/user_repository.dart';
import 'package:mkk/services/logger/logger_service.dart';

import '../../../locator/locator.dart';
import '../../../services/notification/firebase_notification.dart';
import '../../../services/platform.dart';
import '../../models/user_role_model.dart';
import '../local_store_provider.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl();

  final LocalStoreProvider _localStoreProvider = sl.get<LocalStoreProvider>();
  ProfileData _profileData = ProfileData.empty();

  @override
  String? getAccessToken() => _localStoreProvider.accessToken;

  @override
  Future<void> logOut() async {
    if (!isPc()) {
      await sl<FirebaseNotification>().logOut();
    }
    await _localStoreProvider.clear();
    _profileData = ProfileData.empty();
  }

  @override
  Future<void> setAccount(ProfileData account) async {
    L.i(account);
    _profileData = account;
  }

  @override
  String getEmail() => _profileData.email ?? '';

  @override
  String getInn() => _profileData.client.inn;

  @override
  String getName() => _profileData.name;

  @override
  String getShortName() => _profileData.client.shortName;

  @override
  int getUserId() {
    return _profileData.id;
  }

  @override
  Future<void> setAuh(AuthData accountAuth) async {
    L.i(accountAuth);

    await _localStoreProvider.setAccessToken(accountAuth.sessionId);
  }

  @override
  ProfileData get account => _profileData;

  @override
  String? getLocalAuthPin() {
    L.d('getLocalAuthPin(${_localStoreProvider.pin})');
    return _localStoreProvider.pin;
  }

  @override
  Future<void> setLocalAuthPin(String? pin) {
    L.d('setLocalAuthPin($pin)');
    return _localStoreProvider.setPin(pin);
  }

  @override
  Future<void> saveUserLogin(String value) {
    return _localStoreProvider.saveUserLogin(value);
  }

  @override
  String? getUserLogin() {
    return _localStoreProvider.getUserLogin;
  }

  @override
  Future<void> saveRegionalCompany(int value) {
    return _localStoreProvider.saveRegionalCompany(value);
  }

  @override
  int? getRegionalCompany() {
    return _localStoreProvider.getRegionalCompany;
  }

  @override
  Future<void> savePassword(String password) {
    return _localStoreProvider.savePassword(password);
  }

  @override
  String? getPassword() {
    return _localStoreProvider.getPassword;
  }

  @override
  Future<void> saveUserRole(String userRole) {
    return _localStoreProvider.setUserRole(userRole);
  }

  @override
  String? getUserRole() {
    return _localStoreProvider.getUserRole;
  }

  @override
  Future<void> saveUserAccess(List<UserAccess> listUserAccess) {
    return _localStoreProvider.setUserAccess(listUserAccess);
  }

  @override
  List<UserAccess> getUserAccess() {
    return _localStoreProvider.getUserAccess();
  }

  Duration localTimeOffset = Duration.zero;

  @override
  Duration getLocalTimeOffset() {
    return localTimeOffset;
  }

  @override
  void setLocalTimeOffset(Duration offset) {
    localTimeOffset = offset;
  }
}
