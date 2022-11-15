import 'package:shared_preferences/shared_preferences.dart';

/// Хранилище
class LocalStoreClient {
  factory LocalStoreClient() => _instance ?? LocalStoreClient._internal();

  LocalStoreClient._internal();

  static Future<LocalStoreClient> initialize() async {
    try {
      if (_instance == null) {
        _store = await SharedPreferences.getInstance();
      }
    } catch (e) {
      Exception(e);
    }

    return _instance ??= LocalStoreClient._internal();
  }

  static LocalStoreClient? _instance;
  static late SharedPreferences _store;

  SharedPreferences get store => _store;
}
