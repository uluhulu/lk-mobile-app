import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:mkk/data/models/auth_credentials_model.dart';
import '../../core/components/local_store_client.dart';
import '../api/profile/info/entity/profile_info_entity.dart';
import '../models/user_role_model.dart';
import 'dio/transformers/interceptors/dio_auth_synchronizer.dart';

const ACCESSTOKEN = 'user.token';
const PINSTR = 'pinStr';
const REGIONALCOMPANY = 'regionalCompany';
const USERLOGIN = 'user.login';
const USERPASSWORD = 'user.password';
const AUTHCRED = 'authCred';
const USERROLE = 'userRole';
const USERACCESS = 'userAccess';
const SAVEPHOTO = 'settings.savePhoto';

const List<String> removeList = [
  ACCESSTOKEN,
];

/// Локальный провайдер данных
@singleton
class LocalStoreProvider {
  LocalStoreProvider();

  final LocalStoreClient _shareStore = LocalStoreClient();

  String? get accessToken => _shareStore.store.getString(ACCESSTOKEN);

  String? get pin => _shareStore.store.getString(PINSTR);

  int? get getRegionalCompany => _shareStore.store.getInt(REGIONALCOMPANY);

  String? get getUserLogin => _shareStore.store.getString(USERLOGIN);

  String? get getUserRole => _shareStore.store.getString(USERROLE);

  AuthCredentialsModel? get getAuthCred {
    final json = _shareStore.store.getString(AUTHCRED);
    if (json != null) {
      return AuthCredentialsModel.fromJson(jsonDecode(json));
    } else {
      return null;
    }
  }

  Future<void> setAuthCred(AuthCredentialsModel? authCred) async {
    if (authCred != null) {
      await _shareStore.store
          .setString(AUTHCRED, jsonEncode(authCred.toJson()));
    } else {
      await _shareStore.store.remove(AUTHCRED);
    }
  }

  Future<void> setAccessToken(String value) async {
    await _shareStore.store.setString(ACCESSTOKEN, value);
  }

  Future<void> saveRegionalCompany(int value) async {
    await _shareStore.store.setInt(REGIONALCOMPANY, value);
  }

  Future<void> saveUserLogin(String value) async {
    await _shareStore.store.setString(USERLOGIN, value);
  }

  Future<void> savePassword(String password) async {
    await _shareStore.store.setString(USERPASSWORD, password);
  }

  String? get getPassword => _shareStore.store.getString(USERPASSWORD);

  Future<void> setPin(String? pin) async {
    if (pin != null && pin.isNotEmpty) {
      await _shareStore.store.setString(PINSTR, pin);
    } else {
      await _shareStore.store.remove(PINSTR);
    }
  }

  Future<void> setUserRole(String? role) async {
    if (role != null) {
      await _shareStore.store.setString(USERROLE, role);
    } else {
      await _shareStore.store.remove(USERROLE);
    }
  }

  Future<void> setUserAccess(List<UserAccess> listUserAccess) async {
    if (listUserAccess != null) {
      await _shareStore.store.setStringList(
        USERACCESS,
        listUserAccess.map((e) => e.name).toList(),
      );
    } else {
      await _shareStore.store.remove(USERACCESS);
    }
  }

  List<UserAccess> getUserAccess() {
    final list = _shareStore.store.getStringList(USERACCESS);
    if (list != null) {
      final List<UserAccess> listUserAccess = [];
      for (final item in list) {
        final newItem = UserAccessString.fromString(item);
        if (newItem != null) {
          listUserAccess.add(newItem);
        }
      }
      return listUserAccess;
    } else {
      return [];
    }
  }

  bool getSavePhoto() {
    return _shareStore.store.getBool(SAVEPHOTO) ?? true;
  }

  Future<void> setSavePhoto(bool value) async {
    await _shareStore.store.setBool(SAVEPHOTO, value);
  }

  Future<void> clear() async {
    for (var key in removeList) {
      await _shareStore.store.remove(key);
    }
  }
}
