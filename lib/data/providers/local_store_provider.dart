import 'package:injectable/injectable.dart';
import '../../core/components/local_store_client.dart';

const ACCESSTOKEN = 'user.token';
const PINSTR = 'pinStr';
const REGIONALCOMPANY = 'regionalCompany';
const USERLOGIN = 'user.login';

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

  Future<void> setAccessToken(String value) async {
    await _shareStore.store.setString(ACCESSTOKEN, value);
  }

  Future<void> saveRegionalCompany(int value) async {
    await _shareStore.store.setInt(REGIONALCOMPANY, value);
  }

  Future<void> saveUserLogin(String value) async {
    await _shareStore.store.setString(USERLOGIN, value);
  }

  Future<void> setPin(String? pin) async {
    if (pin != null && pin.isNotEmpty) {
      await _shareStore.store.setString(PINSTR, pin);
    } else {
      await _shareStore.store.remove(PINSTR);
    }
  }

  Future<void> clear() async {
    for (var key in removeList) {
      await _shareStore.store.remove(key);
    }
  }
}
